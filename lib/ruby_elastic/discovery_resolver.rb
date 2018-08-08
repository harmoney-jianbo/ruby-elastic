# frozen_string_literal: true

require 'forwardable'

module RubyElastic
  class DiscoveryResolver
    extend Forwardable
    def_delegators :@client, :discovery_servers, :options

    def initialize(client)
      @client = client
    end
    # This method perform server preflight check
    # and update server list if required, support
    # middleware to retrieve servers
    # if (hasDiscoveryServersOutdated()) {
    #   updateDiscoveryServers(next)
    # } else if (hasValidServiceServers()) {
    #   next()
    # } else if (hasDiscoveryServers()) {
    #   updateServiceServers(next)
    # } else {
    #   next(new ResilientError(1002))
    # }
    def resolve
      resover do
        if has_valid_service_servers
          # TODO: already has instance servers, carry on with request
        elsif has_discovery_servers?
          # TODO: get servicers from discovery server
          update_service_servers
        end
      end
    end

    def update_service_servers
      unless options.discovery_processing?
        options.discovery_processing = true
        response = HTTPProxy.make_request('http://localhost:3202/discover1', {}, 'get')
        options.discovery_processing = false
        response
      end
    end

    def has_discovery_servers?
      !discovery_servers.empty?
    end

    def has_valid_service_servers
      false
    end

    private
      def resover
        Concurrent::Promise.execute do
          yield
        end.rescue do |e|
          STDERR.puts e.message
          STDERR.puts e.backtrace.join("\n")
        end
      end
  end
end
