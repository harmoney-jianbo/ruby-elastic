# frozen_string_literal: true
require '../lib/ruby_elastic'

begin
  @client = RubyElastic.setup({base_path: '/api/v1.0'})
  @servers = [
    'http://localhost:3202/discover1',
  ]

  @client.discovery_servers = @servers
  response = @client.get('/orders', {id: 1}, options = {})
  STDERR.puts 'end call'
rescue => e
  raise e if $DEBUG
  STDERR.puts e.message
  STDERR.puts e.backtrace.join("\n")
  exit 1
end
