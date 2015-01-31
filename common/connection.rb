class Connection < Struct.new(:transport, :protocol, :endpoint)

  def self.open(port, client)
    transport = Thrift::BufferedTransport.new(Thrift::Socket.new('0.0.0.0', port))
    protocol = Thrift::BinaryProtocol.new(transport)
    endpoint = client.new(protocol)
    transport.open()
    Connection.new(transport, protocol, endpoint)
  end

  def close
    transport.close
  end

end
