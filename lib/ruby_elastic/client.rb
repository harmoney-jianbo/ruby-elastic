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
        @options.promise_pool << Concurrent::Promise.new do |options|
          p '...'
          p options.inspect
          HTTPProxy.make_request('http://localhost:3202/server4/1', args, verb, options)
        end

        @discovery_resolver.resolve.then do |ret|
          @options.promise_pool.each do |promise|
            promise.execute#({test: 1111})
          end
        end
      end
  end
end
