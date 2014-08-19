# encoding: utf-8
module GeoApi
  class Configuration
    def server
      @server ||= "http://apis.map.qq.com/ws/geocoder/v1"
    end

    def server=(server)
      @server = server
    end

    def key
      @key ||= "test_key"
    end

    def key=(key)
      @key = key
    end
  end
end