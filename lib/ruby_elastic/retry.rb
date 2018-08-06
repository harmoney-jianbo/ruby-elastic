# frozen_string_literal: true

module RubyElastic
  ZuulExceptionError = Class.new(StandardError)
  RetryExceededError = Class.new(StandardError)

  module Retry
    DEFAULT_RETRY = [
      MicroServices::ZuulExceptionError
    ].freeze

    def retry(count = 3, exceptions = [])
      retry_count = count
      begin
        yield
      rescue *retry_exceptions(exceptions) => _e
        retry unless (retry_count -= 1).zero?
        raise MicroServices::RetryExceededError
      end
    end

    private

    def retry_exceptions(exceptions)
      exceptions.empty? ? DEFAULT_RETRY : exceptions
    end
  end
end
