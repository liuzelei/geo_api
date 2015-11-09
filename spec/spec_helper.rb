
require 'bundler/setup'
require 'geo_api'

Bundler.setup

GeoApi.setup do |config|
  # config.server = "http://api.map.baidu.com/geocoder/v2/"
  # config.convert_server = "http://api.map.baidu.com/geoconv/v1/"
  # config.key = "m48tmnl9BPwnhNOctmrVKMRa"

  config.server = "http://apis.map.qq.com/ws/geocoder/v1/"
  config.key = "NM2BZ-V3HRG-ZHMQO-IPJQD-Q375T-EPFRZ"
end

RSpec.configure do |config|
  config.before(:each) do
    # Mongoid.purge!
  end
end