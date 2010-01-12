#!/usr/bin/env ruby
require 'socket'
require 'uri'

include Socket::Constants


socket = Socket.new( Socket::AF_INET, Socket::SOCK_STREAM, 0 )
sockaddr = Socket.pack_sockaddr_in( 2202, 'dev.local' )
socket.bind( sockaddr )
socket.listen( 5 )

while true do
    client, client_sockaddr = socket.accept
    p Socket::unpack_sockaddr_in(client_sockaddr)
    request = client.readline.chomp
    puts "The client said, '#{request}'"
    url = request.split(' ')[1]
    uri = URI.parse(url)
    puts "Server is #{url}"
    p uri.host



    server = Socket.new(Socket::AF_INET, Socket::SOCK_STREAM, 0)
    p "connecting to #{uri.host}:#{uri.port}"
    ret =  server.connect(Socket.sockaddr_in(uri.port, uri.host))
    re = %r{^(\w+) http://#{uri.host}(/?.*?) (HTTP.*)$}
    fields = re.match(request)
    p "connected #{ret}"
    proxyrequest = sprintf "%s %s %s\r\n\r\n", fields[1], \
                      fields[2] == "" ? "/" : fields[2], "HTTP/1.0"
    p "sending '#{proxyrequest}'"
    ret = server.write(proxyrequest)
    p "send #{ret}"
    data = server.read
    p data
    client.write(data)

    client.close
    server.close
end
