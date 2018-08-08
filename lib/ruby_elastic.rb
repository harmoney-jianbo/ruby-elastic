# frozen_string_literal: true

require_relative 'ruby_elastic/version'
require_relative 'ruby_elastic/options'
require_relative 'ruby_elastic/servers'
require_relative 'ruby_elastic/server'
require_relative 'ruby_elastic/round_robin'
require_relative 'ruby_elastic/client'
require_relative 'ruby_elastic/http_proxy'
require_relative 'ruby_elastic/request'
require_relative 'ruby_elastic/response'
require_relative 'ruby_elastic/discovery_resolver'
require_relative 'ruby_elastic/error_checker'

require 'faraday'
require 'concurrent'
require 'pry'


# Usage
# client = RubyElastic.setup({base_path: '/api/v1.0'})
# client.discovery_servers([
#   'http://discover1.server.com',
#   'http://discover2.server.com'
# ])
# response = client.get('/orders', {id: 1}, options = {})
#
module RubyElastic
  def self.setup(options)
    Core.new(options)
  end

  class Core
    include RubyElastic::Client

    attr_reader :options

    def initialize(options)
      @options = RubyElastic::Options.new(options)
      @discovery_resolver = RubyElastic::DiscoveryResolver.new(self)
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
