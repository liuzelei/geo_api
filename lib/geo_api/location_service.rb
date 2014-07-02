# encoding: utf-8
require 'singleton'
require 'net/http'
require 'json'

module GeoApi
  class LocationService
    include Singleton

    def get_location_from_string(location)
      #params = { address: location }
      #result = send_request(params)

      unless location.blank?
        
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

    def coord_to_baidu(coords, from, to)
      params = { coords: coords, from: from, to: to }
      result = send_request(params, 1)

      if result && result["status"] == 0 && result["result"]
        return result["result"]
      else
        return nil
      end
    end

    private
    def send_request(params,url_type = nil)
      uri = URI(GeoApi.config.server)
      if url_type
        uri = URI(GeoApi.config.convert_server)
      end
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
      log.response = JSON.parse(res.body) if res.is_a?(Net::HTTPSuccess)# && !res.body.blank?
      log.save
      result = JSON.parse(res.body) if res.is_a?(Net::HTTPSuccess)# && !res.body.blank?

      return result
    end


  end
end