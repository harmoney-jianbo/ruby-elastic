# frozen_string_literal: true

module RubyElastic
  module Client
    def get(path, args = {}, options = {})
      api_call(path, args, 'get', options)
    end

    def post(_path, _args = {}, _options = {})
      api_call(path, args, 'post', options)
    end

    def put
      raise NotImplementedError
    end

    def delete
      raise NotImplementedError
    end

    def patch
      raise NotImplementedError
    end

    def head
      raise NotImplementedError
    end

    private
      def api_call(path, args = {}, verb = 'get', options = {})
        promise.then do |path|
          HTTPProxy.make_request(path, args, verb, options)
        end
      end

      def promise
        Concurrent::Promise.execute do
          RubyElastic::Resolver.resolve(self)
        end
      end
  end
end
