#!/usr/bin/ruby
require 'socket'

port = ENV.fetch('PORT'){3000}.to_i
wait = ENV.fetch('WAIT'){20}.to_i

host = ENV.fetch('DYNO'){Socket.gethostname}
res_body = "Hello from #{host}!\r\n"
res_body_len = res_body.bytesize
res_header = <<_END.gsub("\n", "\r\n")
HTTP/1.1 200 OK
Content-Length: #{res_body_len}
Content-Type: text/plain; charset=utf-8

_END
res = res_header + res_body

loop do
  $stderr.puts "Accepting incoming connections"
  server = TCPServer.new('0.0.0.0', port)
  socket = server.accept
  req = ""
  while (l = socket.gets) && (l != "\r\n")
    req += l
  end
  socket.write(res)
  server.close
  $stderr.puts "Refusing incoming connections for #{wait} seconds"
  sleep wait
end
