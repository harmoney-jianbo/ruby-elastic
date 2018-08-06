# frozen_string_literal: true

module RubyElastic
  class ErrorChecker
    def initialize(status, body)
      @status = status
      @body = body
    end

    def error
      return AuthenticationError if @status == 401
      return ServerError if @status == 500
      return ClientError if @status >= 400
    end

    def raise_error_if_any
      raise error.new(@status, @body) if error
    end
  end
end
