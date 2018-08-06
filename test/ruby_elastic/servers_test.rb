require "test_helper"

class ServerTest < Minitest::Test
  def setup
    @list = [
      RubyElastic::Server.new('http://test1'),
      RubyElastic::Server.new('http://test2'),
      RubyElastic::Server.new('http://test3')
    ]
  end

  def test_new_servers_instance_without_error
    assert_raises ArgumentError do
      RubyElastic::Servers.new('Invalid')
    end
  end

  def test_empty_servers
    servers = RubyElastic::Servers.new([])
    assert_equal servers.any?, false
  end

  def test_servers_list
    servers = RubyElastic::Servers.new(@list)
    assert_equal servers.any?, true
  end

  def test_get
    servers = RubyElastic::Servers.new(@list)
    assert_equal servers.get, @list
  end

  def test_respond_to_shuffle
    servers = RubyElastic::Servers.new(@list)
    servers.shuffle
  end

  def test_size
    servers = RubyElastic::Servers.new(@list)
    assert_equal servers.size, 3
  end
end
