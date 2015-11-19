require 'coveralls'
Coveralls.wear!

require 'bundler/setup'
require 'geo_api'

Bundler.setup

ENV["RAILS_ENV"] ||= 'test'

RSpec.configure do |config|
  config.before(:each) do
  end
end