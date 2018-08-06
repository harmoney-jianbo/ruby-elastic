module RubyElastic
  class Error < StandardError
    def initialize(status, body)
      super
    end
  end

  AuthenticationError = Class.new(RubyElastic::Error)

  ServerError = Class.new(RubyElastic::Error)

  ClientError = Class.new(RubyElastic::Error)
end
