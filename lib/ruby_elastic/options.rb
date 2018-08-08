# frozen_string_literal: true

# RubyElastic::Options.config do |config|
#   config.base_path = options.dig(:base_path) if options.dig(:base_path)
# end
require 'moneta'

module RubyElastic
  class Options
    attr_accessor :discovery_processing, :promise_pool

    def initialize(options)
      @options = options
      @promise_pool = []
    end

    def base_path
      @base_path
    end

    def base_path=(base_path)
      @base_path = base_path
    end

    def discovery_processing?
      !!discovery_processing
    end

    # Store some entries
    # store['key'] = 'value'

    # Read entry
    # store.key?('key') # returns true
    # store['key'] # returns 'value'

    # store.close
    def store
      @store ||= Moneta.new(:File, dir: 'ruby-elastic')
    end
  end
end
