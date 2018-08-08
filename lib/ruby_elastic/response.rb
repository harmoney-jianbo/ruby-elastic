# frozen_string_literal: true

module RubyElastic
  class Response
    attr_accessor :status

    def initialize(status, body)
      @status = status
      @body = body
    end

    def body
      @response_body ||= JSON.parse(@body)
    end
  end
end
