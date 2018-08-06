# frozen_string_literal: true

module RubyElastic
  module Resolver
    class << self
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
      def resolve(client)
        if has_valid_service_servers
          # TODO: already has instance servers, carry on with request
        elsif has_discovery_servers?
          # TODO: get servicers from discovery server
          update_service_servers
        end
      end

      def update_service_servers
        HTTPProxy.make_request(path, args, verb, options)
      end

      def has_discovery_servers?

      end
    end
  end
end
