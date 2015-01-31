# include thrift-generated code
$:.push('./gen-rb')

require "rubygems"
require "bundler/setup"
require 'thrift'

require 'auth/auth_constants'
require 'auth/server'

class Auth::ServerHandler

  def initialize(options)
    @options = options
  end

  def port
    @options[:port]
  end

  def getUserById(id)
    Auth::User.new(:id => id)
  end

  def getUserByToken(token)
    return nil unless token
    Auth::User.new({
      id: rand(10000),
      token: token
    })
  end

end

port = ENV['PORT'] || 9050
handler = Auth::ServerHandler.new(:port => port, :id => Process.pid)
processor = Auth::Server::Processor.new(handler)

transport = Thrift::ServerSocket.new(handler.port)
transportFactory = Thrift::BufferedTransportFactory.new()
server = Thrift::ThreadPoolServer.new(processor, transport, transportFactory)

puts "Starting the Auth::Server at #{port}"
server.serve()

