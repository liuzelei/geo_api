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
  # config.server = "http://api.map.baidu.com/geocoder/v2/"
  # config.convert_server = "http://api.map.baidu.com/geoconv/v1/"
  # config.key = "m48tmnl9BPwnhNOctmrVKMRa"

  config.server = "http://api.map.baidu.com/geocoder/v2/"
  config.convert_server = "http://apis.map.qq.com/ws/coord/v1/translate"
  config.key = "NM2BZ-V3HRG-ZHMQO-IPJQD-Q375T-EPFRZ"
end

RSpec.configure do |config|
  config.before(:each) do
    # Mongoid.purge!
  end
end