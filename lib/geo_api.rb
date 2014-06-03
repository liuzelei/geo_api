# encoding: utf-8
require "geo_api/version"
require 'geo_api/location_service'
require 'geo_api/configuration'

module GeoApi
  class << self
    def setup
      yield config
    end

    def config
      @config ||= Configuration.new
    end
  end
end