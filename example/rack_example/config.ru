require 'rubygems'
require 'bundler/setup'

require './rack_example/discovery'
require 'eureka'

use Rack::Reloader, 0
run Greeter.new
