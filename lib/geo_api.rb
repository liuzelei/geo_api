require "geo_api/version"
require 'geo_api/configuration'
require "geo_api/baidu"
require "geo_api/gaode"
require 'logger'

module GeoApi
  class << self
    def setup
      yield config
    end

    def config
      @config ||= Configuration.new
    end

    def logger
      @logger ||= Logger.new(STDOUT)
    end

    def proxy
      @proxy ||= get_proxy
    end

    def get_location_from_string(location)
      unless location.nil? || location.length == 0
        formated_address = location.split(/,|-|;|>|:|\+|\^/)
        databack = Hash.new
        databack["province"] = formated_address[0] if formated_address.length > 0
        databack["city"] = formated_address[1] if formated_address.length > 1
        databack["region"] = formated_address[2] if formated_address.length > 2
        databack["detail"] = formated_address[3] if formated_address.length > 3
        databack["latitude"] = ""
        databack["longitude"] = ""

        if ["重庆市", "上海市", "北京市", "天津市"].include?(databack["province"])
          databack["region"] = databack["city"]
          databack["city"] = databack["province"]
        end

        return databack
      else
        return nil
      end
    end

    def get_location_from_coordinate(longitude, latitude)
      proxy.get_location_from_coordinate(longitude, latitude)
    end

    def get_coordinate_from_string(location, city = nil)
      proxy.get_coordinate_from_string(location, city = nil)
    end

    def get_proxy
      case config.vendor
      when 'BAIDU'
        return GeoApi::Baidu.new(config)
      when 'GAODE'
        return GeoApi::Gaode.new(config)
      else
        raise '不支持的Vendor'
      end
    end
  end
end