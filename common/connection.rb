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
  rescue IOError
  end

  def restart
    close
    transport.open
    true
  end

  def with_reconnection(options = {})
    retries = options[:retries] || 3
    begin
      yield
    rescue => e
      retries -= 1
      p [retries]
      if retries > 0
        restart and retry
      else
        raise e
      end
    end
  end

end
