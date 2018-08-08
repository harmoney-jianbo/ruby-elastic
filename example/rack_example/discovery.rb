require 'json'
require 'net/http'
require 'json'

class Discovery
  def initialize(options)
    @options = options
  end

  def call(env)
    @env = env
    case request.path
    when '/discover1'
      [200, { 'Content-Type' => 'application/json' }, [ discover1.to_json ]]
    when '/server3/error'
      Rack::Response.new('Internal Server Error', 500)
    when '/server2/timeout'
      Rack::Response.new('Timeout error', 524)
    when '/server1/notfound'
      Rack::Response.new('Not found', 404)
    when '/server4/1'
      [200, { 'Content-Type' => 'application/json' }, [ {status: 'ok'}.to_json ]]
    else
      Rack::Response.new('Not found', 404)
    end
  end

  def request
    Rack::Request.new(@env)
  end

  private
    def service_port
      @options.dig('port')
    end

    def discover1
      [
        "http://localhost:#{service_port}/server1/notfound",
        "http://localhost:#{service_port}/server2/timeout",
        "http://localhost:#{service_port}/server3/error",
        "http://localhost:#{service_port}/server4/1"
      ]
    end
end
