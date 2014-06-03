# encoding: utf-8
require 'singleton'
require 'net/http'
require 'json'

module GeoApi
  class LocationService
    #extend SetLog
    include Singleton

    def get_location_from_string(location)
      params = { address: location }
      result = send_request(params)

      if result && result["status"] == 0 && result["result"]
        lat = result["result"]["location"]["lat"].to_s
        lng = result["result"]["location"]["lng"].to_s

        databack = get_location_from_coordinate(lat,lng)

        return databack
      end
    end

    def get_location_from_coordinate(latitude, longitude)
      params = { location: "%s, %s" % [latitude, longitude] }
      result = send_request(params)

      if result && result["status"] == 0 && result["result"]

        databack = Hash.new
        databack["province"] = result["result"]["addressComponent"]["province"]
        databack["city"] = result["result"]["addressComponent"]["city"]
        databack["region"] = result["result"]["addressComponent"]["district"]
        databack["detail"] = result["result"]["addressComponent"]["street"] + result["result"]["addressComponent"]["street_number"]
        databack["latitude"] = result["result"]["location"]["lat"].to_s
        databack["longitude"] = result["result"]["location"]["lng"].to_s

        return databack
      end
    end

    private
    def send_request(params)
      uri = URI(GeoApi.config.server)
      params[:ak] = GeoApi.config.key
      params[:output] = 'json'
      uri.query = URI.encode_www_form(params)
      res = Net::HTTP.get_response(uri)
      result = JSON.parse(res.body) if res.is_a?(Net::HTTPSuccess)
      return result
    end
  end
end