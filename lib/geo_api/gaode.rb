require 'net/http'
require 'json'

module GeoApi
  class Gaode
    attr_accessor :config

    def initialize(config)
      @config = config
    end

    def get_location_from_coordinate(longitude, latitude)
      params = { location: "%s,%s" % [longitude, latitude], key: @config.key }
      result = send_request('regeo', params)
      if !result.nil? && result["status"] == "1" && !result["regeocode"].nil?
        databack = Hash.new
        databack["address"] = result["regeocode"]["formatted_address"]
        databack["province"] = result["regeocode"]["addressComponent"]["province"]
        databack["city"] = result["regeocode"]["addressComponent"]["city"]
        databack["city"] = databack["province"] if databack["city"].nil? || databack["city"].length == 0
        databack["region"] = result["regeocode"]["addressComponent"]["district"]
        databack["detail"] = result["regeocode"]["addressComponent"]["township"]

        return databack
      else
        return nil
      end
    end

    def get_coordinate_from_string(location, city = nil)
      params = { address: location, city: city, key: @config.key }
      result = send_request('geo', params)
      if !result.nil? && result["status"] == "1" && !result["geocodes"].nil? && result["geocodes"].length > 0
        location = result["geocodes"][0]["location"].split(',')
        return { longitude: location[0], latitude: location[1] }
      else
        return nil
      end
    end

    private
    def send_request(path, params)
      uri = URI("#{@config.server}#{path}")
      params[:output] = 'json'
      uri.query = URI.encode_www_form(params)
      res = Net::HTTP.get_response(uri)
      result = JSON.parse(res.body) if res.is_a?(Net::HTTPSuccess)# && !res.body.blank?
      return result
    end
  end
end
