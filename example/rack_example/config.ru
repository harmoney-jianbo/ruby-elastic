require 'rubygems'
require 'bundler/setup'

require './rack_example/discovery'

args = Hash[ ARGV.flat_map{|s| s.scan(/--?([^=\s]+)(?:=(\S+))?/) } ]
use Rack::Reloader, 0
run Discovery.new(args)
