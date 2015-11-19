require 'net/http'
require 'json'

module GeoApi
  class Baidu
    attr_accessor :config

    def initialize(config)
      @config = config
    end

    def get_location_from_coordinate(latitude, longitude)
      params = { location: "%s,%s" % [latitude, longitude], coordtype: 5, key: @config.key }
      result = send_request(params)
      if result && result["status"] == 0 && result["result"]
        databack = Hash.new
        databack["address"] = result["result"]["address"]
        databack["province"] = result["result"]["address_component"]["province"]
        databack["city"] = result["result"]["address_component"]["city"]
        databack["region"] = result["result"]["address_component"]["district"]
        databack["detail"] = result["result"]["address_component"]["street"] + result["result"]["address_component"]["street_number"]

        return databack
      else
        return nil
      end
    end

    def get_coordinate_from_string(location, city = nil)
      params = { address: location, region: city, key: @config.key }
      result = send_request(params)

      if result["status"] == 0
        return { longitude: result["result"]["lng"], latitude: result["result"]["lat"] }
      else
        return nil
      end
    end

    private
    def send_request(params)
      uri = URI(@config.server)
      params[:output] = 'json'
      uri.query = URI.encode_www_form(params)
      res = Net::HTTP.get_response(uri)
      result = JSON.parse(res.body) if res.is_a?(Net::HTTPSuccess)# && !res.body.blank?

      return result
    end
  end
end
