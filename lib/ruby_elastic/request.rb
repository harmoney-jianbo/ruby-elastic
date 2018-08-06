# frozen_string_literal: true

module RubyElastic
  class Request
    attr_reader :raw_path, :raw_args, :raw_verb

    def initialize(path:, verb:, args: {}, options: {})
      @raw_path = path
      @raw_args = args
      @raw_verb = verb.to_s.downcase
      @raw_options = options
      raise ArgumentError, 'missing required path' unless @raw_path
      raise ArgumentError unless %w[get post].include? @raw_verb
    end

    def path
      @path ||= @raw_path % @raw_args if get?
    end

    def get?
      @raw_verb == 'get'
    end

    def post?
      @raw_verb == 'post'
    end

    def access_token
      @raw_args['access_token']
    end

    def args
      (@raw_args || {}).reject do |k, _v|
        @raw_path.include?("%{#{k}}")
      end
    end

    def verb
      @raw_verb
    end

    def options
      default_options(@raw_options)
    end

    private

    def default_options(options)
      ssl = { verify: false }.merge(options[:ssl] || {})
      { ssl: ssl }.merge(options)
    end
  end
end
