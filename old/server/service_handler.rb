# provide an implementation of Service
class ServiceHandler

  def initialize(options = {})
    @id = options[:id]
    @port = options[:port]
  end

  def find(params)
    p [:find, @id, @port]
    return []
  end

  def get(id)
    resource = Resource.new(:id => id)
    p [:get, @id, @port, resource]
    resource
  end

  def create(params)
    Resource.new(params)
  end

  def update(id, params)
    Resource.new(params.merge(:id => id))
  end

  def update(id, params)
    true
  end

end

