# include thrift-generated code
$:.push('./gen-rb')

require "rubygems"
require "bundler/setup"
require 'thrift'

require 'auth/auth_constants'
require 'auth/server'

port = ENV['PORT'] || 9090

class Auth::ServerHandler

  def initialize(options)
    @options = options
  end

  def getUserById(id)
    Auth::User.new(:id => id)
  end

end

handler = Auth::ServerHandler.new(:port => port, :id => Process.pid)
processor = Auth::Server::Processor.new(handler)

transport = Thrift::ServerSocket.new(port)
transportFactory = Thrift::BufferedTransportFactory.new()
server = Thrift::ThreadPoolServer.new(processor, transport, transportFactory)

puts "Starting the Auth::Server..."
server.serve()
puts "Done"

