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
    loop do 
        begin
            chunk = s.read_nonblock(1024)
        rescue Errno::EAGAIN
            IO.select([s])
            retry
        rescue EOFError
            break
        end
        data += chunk
        break if /\r\n\r\n\Z/m.match(chunk)
    end 

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
    request = read_response(client)
    request.gsub!(/\r\n\r\n\Z/m, '')
    request_lines = request.split("\r\n")
        
    url = request_lines[0].split(' ')[1]
    uri = URI.parse(url)


    printf ">> client request %s\n", request_lines[0]
    server = TCPSocket.new(uri.host, uri.port)
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


