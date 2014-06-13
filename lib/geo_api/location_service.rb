# encoding: utf-8
require 'singleton'
require 'net/http'
require 'json'

module GeoApi
  class LocationService
    include Singleton

    def get_location_from_string(location)
      params = { address: location }
      result = send_request(params)

      if result && result["status"] == 0 && result["result"]
        latitude = result["result"]["location"]["lat"].to_s
        longitude = result["result"]["location"]["lng"].to_s

        databack = get_location_from_coordinate(latitude, longitude)

        return databack
      else
        return nil
      end
    end

    def get_location_from_coordinate(latitude, longitude, coordtype = 'bd09ll')
      params = { location: "%s, %s" % [latitude, longitude], coordtype: coordtype }
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
      else
        return nil
      end
    end

    private
    def send_request(params)
      uri = URI(GeoApi.config.server)
      params[:ak] = GeoApi.config.key
      params[:output] = 'json'
      uri.query = URI.encode_www_form(params)
      GeoApi.logger.debug uri.inspect
      res = Net::HTTP.get_response(uri)

      log = GeoApi::Models::LocationLog.new
      log.url = uri
      begin
        log.request = JSON.parse(params.to_json)
      rescue
        log.raw_request = params
      end
      GeoApi.logger.debug res.body
      log.response = JSON.parse(res.body) if res.is_a?(Net::HTTPSuccess) && !res.body.blank?
      log.save
      result = JSON.parse(res.body) if res.is_a?(Net::HTTPSuccess) && !res.body.blank?
      GeoApi.logger.debug res.body
      return result
    end


  end
end