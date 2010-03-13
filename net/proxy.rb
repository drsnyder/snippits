#!/usr/bin/env ruby
require 'socket'
require 'uri'
require 'rubygems'
require 'optparse'
require 'ostruct'


options = OpenStruct.new
options.port = '2202'
options.host = 'dev.local'


opts = OptionParser.new do |opts|
    opts.banner = "Usage: #{File.basename(__FILE__)} [options]"

    opts.separator ""

    opts.on("-P", "--port PORT", "The port to bind to.") do |port|
        options.port = port
    end

    opts.on("-H", "--host HOST", "The host to bind to.") do |host|
        options.host = host
    end

    opts.separator ""

    opts.on_tail("-h", "--help", "Show this message") do
        puts opts
        exit
    end

end

opts.parse!(ARGV)



def read_response(s)
    data = ""
    chunk = ""
    header = Hash.new()
    loop do 
        begin
            chunk = s.read_nonblock(1024)
        rescue Errno::EAGAIN
            IO.select([s])
            retry
        rescue EOFError
            break
        end

        if data == ""
            headersection, body = chunk.split("\r\n\r\n")
            headerlines = headersection.split("\r\n")
            # skip the request type/spec line
            headerlines[1..headerlines.length - 1].each do |line|
                key, value = line.split(': ')
                header[key] = value.downcase
            end

            if header.has_key?("Transfer-Encoding") \
                and header["Transfer-Encoding"] == "chunked"
                len_line = /^([a-fA-F0-9]+)\r\n/.match(body)
                if len_line
                    response_length = len_line[1].hex
                    printf ">>> Chunk length is %d\n", response_length
                else
                    printf "*** Error, the length for the chunked encoding falied to parse\n"
                end

            end
        end

        data += chunk
        if m = /Content-Length: (\d+)/i.match(chunk)
            printf ">>> Content-Lenght specified at %d\n", m[1]
        end
        if /Transfer-Encoding: chunked/i.match(chunk)
            printf ">>> Chunked encoding specified: '%s'\n", chunk
        end
        break if /\r\n\r\n\Z/m.match(chunk)
        break if /\r\n0\r\n\r\n\Z/m.match(chunk)
    end 


    printf ">>> Read %d data\n", data.length
    data
end

socket = Socket.new( Socket::AF_INET, Socket::SOCK_STREAM, 0 )
sockaddr = Socket.pack_sockaddr_in( options.port, options.host )
socket.bind( sockaddr )
socket.listen( 5 )

trap("INT") do
    socket.close
    exit
end
trap("TERM") do
    socket.close
    exit
end

while true do
    client, client_sockaddr = socket.accept

    pid = Process.fork do

        request = read_response(client)
        request.gsub!(/\r\n\r\n\Z/m, '')
        request_lines = request.split("\r\n")

        url = request_lines[0].split(' ')[1]
        uri = URI.parse(url)


        # look it using the host header value
        printf ">> client request %s\n", request_lines[0]
        begin 
            server = TCPSocket.new(uri.host, uri.port)
        rescue SocketError => error
            printf ">>>> Error %s: %s\n", error, request_lines.join("\n>>>>")
            printf ">>>> Skipping \n"
            client.close
            next  
        end
        printf ">> connecting to %s:%d\n", uri.host, uri.port
        re = %r{^(\w+) http://#{uri.host}(/?.*?) (HTTP.*)$}
            fields = re.match(request_lines[0])
        proxyrequest = sprintf "%s %s %s\r\nHost: %s\r\n\r\n", fields[1], \
            fields[2] == "" ? "/" : fields[2], fields[3], uri.host
        proxyrequest += request_lines[1..request_lines.length - 1].join("\r\n") + "\r\n\r\n"
        server.write(proxyrequest)
        data = read_response(server)
        printf ">> read %db from %s\n\n", data.length, uri.host
        client.write(data)

        client.close
        server.close
    end
    Process.detach(pid)
end


