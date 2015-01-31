# include thrift-generated code
$:.push('./gen-rb')

require "rubygems"
require "bundler/setup"
require 'thrift'

require 'service'
require 'service_constants'
require './server/service_handler'

port = ENV['PORT'] || 9090
handler = ServiceHandler.new(:port => port, :id => Process.pid)
processor = Service::Processor.new(handler)

transport = Thrift::ServerSocket.new(port)
transportFactory = Thrift::BufferedTransportFactory.new()
server = Thrift::ThreadPoolServer.new(processor, transport, transportFactory)

puts "Starting the Service server..."
server.serve()
puts "Done"

