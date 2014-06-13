# encoding: utf-8
require 'spec_helper'

describe "test location" do
  it "should get location by string" do
    location_str = "上海灵岩路79弄1号"

    databack = Hash.new
    databack["province"] = "上海市"
    databack["city"] = "上海市"
    databack["region"] = "浦东新区" 
    databack["detail"] = "灵岩路79弄-1号"
    databack["latitude"] = "31.172419183453"
    databack["longitude"] = "121.50055678999"

    location = GeoApi::LocationService.instance.get_location_from_string(location_str)

    expect(location).to eq(databack)

    location = GeoApi::LocationService.instance.get_location_from_string("上海灵岩路79弄1号")
    expect(location["province"]).to eq("上海市")
    expect(location["city"]).to eq("上海市")
    expect(location["region"]).to eq("浦东新区")

    location = GeoApi::LocationService.instance.get_location_from_string("")
    expect(location).to eq("")

    location = GeoApi::LocationService.instance.get_location_from_string("小桥大街西宁")
    expect(location["province"]).to eq("青海省")
    expect(location["city"]).to eq("西宁市")
    expect(location["region"]).to eq("城北区")
  end
end

describe "test location form coordinate" do
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