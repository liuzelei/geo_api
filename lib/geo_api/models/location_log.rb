require 'mongoid'
module GeoApi
  module Models
    class LocationLog
      include Mongoid::Document

      
      field :request_body, type: String
      field :response_body, type: String

    end
  end
end