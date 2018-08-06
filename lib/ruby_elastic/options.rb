# frozen_string_literal: true

# RubyElastic::Options.config do |config|
#   config.base_path = options.dig(:base_path) if options.dig(:base_path)
# end
require 'moneta'

module RubyElastic
  module Options
    def self.setup(options)
    end

    def self.base_path
      @base_path
    end

    def self.base_path=(base_path)
      @base_path = base_path
    end

    # Default way to set up Euraka
    def self.config
      yield self
    end

    # Store some entries
    # store['key'] = 'value'

    # Read entry
    # store.key?('key') # returns true
    # store['key'] # returns 'value'

    # store.close
    def self.store
      @store ||= Moneta.new(:File, dir: 'ruby-elastic')
    end
  end
end
