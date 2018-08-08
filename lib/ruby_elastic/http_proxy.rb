# frozen_string_literal: true

module RubyElastic
  module HTTPProxy
    class << self
      attr_accessor :http_service
    end

    def self.make_request(path, args, verb, options = {})
      http_service.make_request(RubyElastic::Request.new(path: path, args: args, verb: verb, options: options))
    end

    module HTTPService
      def self.make_request(req)
        con = connection(req)
        build_response!(con.send(req.verb, req.path, req.args))
      end

      def self.connection(req)
        con = ::Faraday.new('http://test', req.options)
        con.headers['Accept'] = 'application/json'
        # con.headers['Authorization'] = 'Bearer ' + req.access_token
        con
      end

      def self.build_response!(response)
        RubyElastic::ErrorChecker.new(response.status, response.body).raise_error_if_any
        RubyElastic::Response.new(response.status, response.body)
      end
    end

    self.http_service = HTTPService
  end
end
