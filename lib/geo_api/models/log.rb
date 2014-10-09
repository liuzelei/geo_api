require 'mongoid'
module GeoApi
  module Models
    class Log
      include Mongoid::Document

      field :url, type: String
      field :request, type: Hash
      field :raw_request, type: String
      field :response, type: Hash

    end
  end
end