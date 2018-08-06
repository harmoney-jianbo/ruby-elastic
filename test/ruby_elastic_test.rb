require "test_helper"

class RubyElasticTest < Minitest::Test
  def setup
    @client = RubyElastic.setup({base_path: '/api/v1.0'})
    @servers = [
      'http://api1.server.com',
      'http://api2.server.com',
      'http://api3.server.com'
    ]
  end

  def test_that_it_has_a_version_number
    refute_nil ::RubyElastic::VERSION
  end

  def test_set_discover_servers
    @client.discovery_servers = ['http://api3.server.com']
    assert_equal ['http://api3.server.com'], @client.discovery_servers
  end

  def test_set_discover_servers_raise_argument_error
    assert_raises ArgumentError do
      @client.discovery_servers = []
    end
  end

  def test_getter_discover_servers
    @client.discovery_servers = @servers
    count = @client.discovery_servers.select { |server| server.is_a?(RubyElastic::Server) }.count
    assert_equal @servers.count, count
  end


  # Usage
  # client = RubyElastic.setup({base_path: '/api/v1.0'})
  # client.discovery_servers([
  #   'http://discover1.server.com',
  #   'http://discover2.server.com'
  # ])
  # response = client.get('/orders', {id: 1}, options = {})
  #
  def test_get_request
    client = RubyElastic.setup({base_path: '/api/v1.0'})
    client.discovery_servers = @servers
    response = client.get('/orders', {id: 1}, options = {})
  end
end
