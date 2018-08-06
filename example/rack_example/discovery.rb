require 'json'
require 'net/http'
require 'json'

class Greeter
  def call(env)
    @env = env
    case request.path
    when '/discover1'
      [200, { 'Content-Type' => 'application/json' }, [ discover1.to_json ]]
    when '/discover12'
      [200, { 'Content-Type' => 'application/json' }, [ discover2.to_json ]]
    end
  end

  def request
    Rack::Request.new(@env)
  end

  private
    def discover1
      [
        'http://localhost:3201/server1/timeout',
        'http://localhost:3201/server2/error',
        'http://localhost:3201/server3/1'
      ]
    end

    def discover2
      [
        'http://localhost:3201/server1/timeout',
        'http://localhost:3201/server2/error',
        'http://localhost:3201/server3/1'
      ]
    end
end
