# encoding utf-8
require 'coveralls'
Coveralls.wear!

require 'bundler/setup'
require 'geo_api'
require 'mongoid'

Bundler.setup

ENV["RAILS_ENV"] ||= 'test'
ENV["MONGOID_SPEC_HOST"] ||= "localhost"
ENV["MONGOID_SPEC_PORT"] ||= "27017"

HOST = ENV["MONGOID_SPEC_HOST"]
PORT = ENV["MONGOID_SPEC_PORT"].to_i

def database_id
  "sashimi_test"
end


CONFIG = {
  sessions: {
    default: {
      database: database_id,
      hosts: [ "#{HOST}:#{PORT}" ]
    }
  }
}

# Set the database that the spec suite connects to.
Mongoid.configure do |config|
  config.load_configuration(CONFIG)
end

GeoApi.setup do |config|
  config.server = "http://api.map.baidu.com/geocoder/v2/"
  config.key = "09f24306fde8dd0f7e73a3f977c2c584"
end

RSpec.configure do |config|
  config.before(:each) do
    # Mongoid.purge!
  end
end