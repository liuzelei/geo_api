# encoding: utf-8
require 'spec_helper'

describe "test location" do
  it "should get location by string" do
    location = GeoApi::LocationService.instance.get_location_from_string("上海市-灵岩路-79弄1号")
    expect(location["province"]).to eq("上海市")
    expect(location["city"]).to eq("上海市")
    #expect(location["region"]).to eq("浦东新区")

    location = GeoApi::LocationService.instance.get_location_from_string("")
    expect(location).to eq(nil)

    location = GeoApi::LocationService.instance.get_location_from_string("青海省,西宁市,城北区")
    expect(location["province"]).to eq("青海省")
    expect(location["city"]).to eq("西宁市")
    expect(location["region"]).to eq("城北区")

    # location = GeoApi::LocationService.instance.get_location_from_string("城北区")
    # expect(location["province"]).not_to eq("城北区")
  end
end

describe "test location form coordinate" do

  it "should coord to baidu" do
    coords = []

    500.times do 
      coords << "121.4660492,31.2117575"
      coords << "121.4664967,31.2111130"
    end

    data_back = GeoApi::LocationService.instance.coord_to_baidu(coords.join(';'), "3", "5")
    start_x = "121.47254115402"
    start_y = "31.217835218563"
    end_x = "121.47299026673"
    end_y = "31.217182204029"

    data_back.each_with_index do |result, index|
      if index % 2 == 0
          expect(result["x"].to_s).to eq(start_x)
          expect(result["y"].to_s).to eq(start_y)
      else
          expect(result["x"].to_s).to eq(end_x)
          expect(result["y"].to_s).to eq(end_y)
      end
    end
  end

  it "should get location by coordinate" do
    latitude = "39.9834"
    longitude = "116.3229"

    location = GeoApi::LocationService.instance.get_location_from_coordinate(latitude, longitude)
    expect(location["province"]).to eq("北京市")
    expect(location["city"]).to eq("北京市")
    expect(location["region"]).to eq("海淀区")

    latitude = "36.66"
    longitude = "101.76"

    location = GeoApi::LocationService.instance.get_location_from_coordinate(latitude, longitude)
    expect(location["province"]).to eq("青海省")
    expect(location["city"]).to eq("西宁市")
    expect(location["region"]).to eq("城北区")
  end
end