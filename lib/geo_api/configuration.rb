module GeoApi

  class << self
    attr_accessor :configuration

    def config
      self.configuration ||= Configuration.new
    end

    def configure
      yield config if block_given?
    end
  end

  class Configuration
    attr_accessor :baidu_map_server,:baidu_map_key
  end

  module ConfigurationHelpers
    def geo_server
      @geo_server ||= GeoApi.config.baidu_map_server
    end

    def geo_key
      @geo_key ||= GeoApi.config.baidu_map_key
    end
  end

  module SetLog

  end
end