# include thrift-generated code
$:.push('./gen-rb')

require "rubygems"
require "bundler/setup"
require 'thrift'

require 'auth/auth_constants'
require 'auth/server'

transport = Thrift::BufferedTransport.new(Thrift::Socket.new('0.0.0.0', 9089))
protocol = Thrift::BinaryProtocol.new(transport)
endpoint = Auth::Server::Client.new(protocol)
transport.open()

trap('INT') do
  transport.close()
  exit
end

loop do
  id = rand(1000000)
  result = endpoint.getUserById(id)
  p [:client, Process.pid, id, result]
  sleep 5
end


