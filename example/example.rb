# frozen_string_literal: true

@client = RubyElastic.setup({base_path: '/api/v1.0'})
@servers = [
  'http://localhost:3100/discover1',
  'http://localhost:3100/discover2'
]

client.discovery_servers = @servers
response = client.get('/orders', {id: 1}, options = {})
