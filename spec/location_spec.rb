require 'spec_helper'

describe "test location" do
  before(:each) do
    GeoApi.setup do |config|
    # config.server = "http://api.map.baidu.com/geocoder/v2/"
    # config.convert_server = "http://api.map.baidu.com/geoconv/v1/"
    # config.key = "m48tmnl9BPwnhNOctmrVKMRa"
    config.server = 'http://restapi.amap.com/v3/geocode/'
    config.key = '54da1e114715acb235ca8d8f1d17d5f9'
    config.vendor = 'GAODE'
    # config.server = "http://apis.map.qq.com/ws/geocoder/v1/"
    # config.key = "NM2BZ-V3HRG-ZHMQO-IPJQD-Q375T-EPFRZ"
  end

  end
  it "get location by string" do
    p GeoApi.proxy
    location = GeoApi.get_location_from_string("上海市-灵岩路-79弄1号")
    expect(location["province"]).to eq("上海市")
    expect(location["city"]).to eq("上海市")
    #expect(location["region"]).to eq("浦东新区")

    location = GeoApi.get_location_from_string("")
    expect(location).to eq(nil)

    location = GeoApi.get_location_from_string("青海省,西宁市,城北区")
    expect(location["province"]).to eq("青海省")
    expect(location["city"]).to eq("西宁市")
    expect(location["region"]).to eq("城北区")

    # location = GeoApi.get_location_from_string("城北区")
    # expect(location["province"]).not_to eq("城北区")
  end

  it "get location by coordinate" do
    latitude = "39.9834"
    longitude = "116.3229"

    location = GeoApi.get_location_from_coordinate(longitude, latitude)
    expect(location["province"]).to eq("北京市")
    expect(location["city"]).to eq("北京市")
    expect(location["region"]).to eq("海淀区")

    latitude = "36.66"
    longitude = "101.76"

    location = GeoApi.get_location_from_coordinate(longitude, latitude)
    expect(location["province"]).to eq("青海省")
    expect(location["city"]).to eq("西宁市")
    expect(location["region"]).to eq("城北区")
  end

  it "get coordinate from string" do
    result = GeoApi.get_coordinate_from_string("思南路115弄")
    expect(result[:longitude]).not_to be_empty
    expect(result[:latitude]).not_to be_empty

    result = GeoApi.get_coordinate_from_string("思南路115弄", "上海市")
   
    expect(result[:longitude]).not_to be_empty
    expect(result[:latitude]).not_to be_empty

    result = GeoApi.get_coordinate_from_string("")
    
    expect(result).to eq(nil)

    # 500.times do
    #   result = GeoApi.get_coordinate_from_string("思南路115弄")
    #   if result.nil?
    #     GeoApi.logger.debug("====失败!")
    #   end
    # end
  end
end
