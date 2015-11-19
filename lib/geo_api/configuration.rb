module GeoApi
  class Configuration
    def server
      @server ||= "http://api.map.baidu.com/geocoder/v2/"
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

    def vendor
      @vendor ||= 'BAIDU'
    end

    def vendor=(vendor)
      @vendor = vendor
    end
  end
end