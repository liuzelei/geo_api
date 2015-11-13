# encoding: utf-8
require "geo_api/version"
require 'geo_api/configuration'
require 'logger'
require 'net/http'
require 'json'

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

    def get_location_from_string(location)
      if !location.nil? && !location.empty?
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

    def get_location_from_coordinate(latitude, longitude, coordtype = 5)
      params = { location: "%s,%s" % [latitude, longitude], coordtype: coordtype, key: GeoApi.config.key }
      result = send_request(params)
      if result && result["status"] == 0 && result["result"]
        databack = Hash.new
        databack["address"] = result["result"]["address"]
        databack["province"] = result["result"]["address_component"]["province"]
        databack["city"] = result["result"]["address_component"]["city"]
        databack["region"] = result["result"]["address_component"]["district"]
        databack["detail"] = "#{result['result']['address_component']['street']}#{result['result']['address_component']['street_number']}"
        databack["latitude"] = result["result"]["location"]["lat"].to_s
        databack["longitude"] = result["result"]["location"]["lng"].to_s

        return databack
      else
        return nil
      end
    end

    def get_coordinate_from_string(location, city = nil)
      params = { address: location, region: city, key: GeoApi.config.key }
      result = send_request(params)

      if result["status"] == 0
        return result["result"]
      else
        return nil
      end
    end

    private
    def send_request(params)
      uri = URI(GeoApi.config.server)
      params[:output] = 'json'
      uri.query = URI.encode_www_form(params)
      res = Net::HTTP.get_response(uri)
      result = JSON.parse(res.body) if res.is_a?(Net::HTTPSuccess)# && !res.body.blank?

      return result
    end
  end
end