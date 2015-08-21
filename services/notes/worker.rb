# include thrift-generated code
$:.push('./gen-rb')

trap('INT') { exit }
require "rubygems"
require "bundler/setup"
require 'thrift'

require 'auth/auth_constants'
require 'notes/notes_constants'
require 'notes/server'

class Notes::ServerHandler

  def initialize(options)
    @options = options
  end

  def port
    @options[:port]
  end

  def addNote(user, text)
    Notes::Note.new({
      id: rand(10000),
      user_id: user.id,
      text: text
    })
  end

  def deleteNote(user, id)
    true
  end

end

port = ENV['PORT'] || 9060
handler = Notes::ServerHandler.new(:port => port, :id => Process.pid)
processor = Notes::Server::Processor.new(handler)

transport = Thrift::ServerSocket.new(handler.port)
transportFactory = Thrift::BufferedTransportFactory.new()
server = Thrift::ThreadPoolServer.new(processor, transport, transportFactory)

puts "Starting the Note::Server at #{port}"
server.serve()
puts "Done"


