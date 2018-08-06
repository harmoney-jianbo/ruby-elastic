# frozen_string_literal: true

require 'ruby_elastic/version'
require 'ruby_elastic/options'
require 'ruby_elastic/servers'
require 'ruby_elastic/server'
require 'ruby_elastic/round_robin'
require 'ruby_elastic/client'
require 'ruby_elastic/base'
require 'ruby_elastic/http_proxy'
require 'ruby_elastic/request'
require 'faraday'
require 'concurrent'

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
    Base.new(options)
  end
end
