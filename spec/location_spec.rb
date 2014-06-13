# encoding: utf-8
require 'spec_helper'

# describe "test location" do
#   it "should get location by string" do
#     location = GeoApi::LocationService.instance.get_location_from_string("上海市-灵岩路-79弄1号")
#     expect(location["province"]).to eq("上海市")
#     expect(location["city"]).to eq("上海市")
#     #expect(location["region"]).to eq("浦东新区")

#     location = GeoApi::LocationService.instance.get_location_from_string("")
#     expect(location).to eq(nil)

#     location = GeoApi::LocationService.instance.get_location_from_string("青海省,西宁市,城北区")
#     expect(location["province"]).to eq("青海省")
#     expect(location["city"]).to eq("西宁市")
#     expect(location["region"]).to eq("城北区")

#     location = GeoApi::LocationService.instance.get_location_from_string("城北区")
#     expect(location["province"]).not_to eq("城北区")
#   end
# end

describe "test location form coordinate" do
  # it "should get location by coordinate" do
  #   latitude = "39.9834"
  #   longitude = "116.3229"

  #   location = GeoApi::LocationService.instance.get_location_from_coordinate(latitude, longitude)
  #   expect(location["province"]).to eq("北京市")
  #   expect(location["city"]).to eq("北京市")
  #   expect(location["region"]).to eq("海淀区")

  #   latitude = "36.66"
  #   longitude = "101.76"

  #   location = GeoApi::LocationService.instance.get_location_from_coordinate(latitude, longitude)
  #   expect(location["province"]).to eq("青海省")
  #   expect(location["city"]).to eq("西宁市")
  #   expect(location["region"]).to eq("城北区")
  # end

  it "should test baidu geo api" do
    correct_counter = 0
    faild_counter = 0
    GeoApi.logger.debug("begin")
    10000.times do |time|
      begin
        GeoApi::LocationService.instance.get_location_from_coordinate("39.9834", "116.3229")
        correct_counter = correct_counter + 1
      rescue
        faild_counter = faild_counter + 1
      end
      GeoApi.logger.debug("#{time}--#{Time.now}")
    end
    GeoApi.logger.debug("#{faild_counter}/#{correct_counter}")
  end
end