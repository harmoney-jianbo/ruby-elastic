# frozen_string_literal: true

module RubyElastic
  class Base
    include RubyElastic::Client

    def initialize(options)
      @options = RubyElastic::Options.setup(options)
      @discovery_servers = []
    end

    def discovery_servers=(*servers)
      raise ArgumentError, 'Missing required server array' if servers.flatten!.empty?
      @discovery_servers = servers
    end

    def discovery_servers
      @discovery_server_list ||= RubyElastic::Servers.new(@discovery_servers)
    end

    def has_discovery_servers?
      !discovery_servers.empty?
    end
  end
end
