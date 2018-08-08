# frozen_string_literal: true

require 'forwardable'

module RubyElastic
  class Servers
    extend Forwardable
    include Enumerable

    def_delegators :@servers, :shuffle, :empty?

    alias size count

    def initialize(*servers)
      setup_servers(servers.flatten)
    end

    def each(*args, &block)
      @servers.each(*args, &block)
    end

    def get
      @servers
    end

    def setup_servers(servers)
      @servers = servers.flatten.map { |server| Server.new(server) }
      @updated = Time.now.to_i
      raise ArgumentError, 'Invalid server array' unless valid_servers?
    end

    def last_update
      Time.now.to_i - @updated
    end

    def sort
      roundRobinSort(servers)
    end

    private
      def valid_servers?
        @servers.all? { |server| Server === server }
      end

      def roundRobinSort(servers, options = { round_robin_size: 2 })
        size = servers.length > options.dig(:round_robin_size) ? servers.length : options.dig(:round_robin_size)
        RoundRobin.round_robin(servers, size)
      end
  end
end
