require 'spec_helper'

describe "test baidu" do
  let(:config) do
    config = GeoApi::Configuration.new
    config.server = "http://api.map.baidu.com/geocoder/v2/"
    config.key = "m48tmnl9BPwnhNOctmrVKMRa"
    config.vendor = "BAIDU"
    config
  end
  let(:baidu) { GeoApi::Baidu.new(config) }

  it "get location by coordinate" do
    latitude = "39.9834"
    longitude = "116.3229"

    location = baidu.get_location_from_coordinate(longitude, latitude)
    expect(location["province"]).to eq("北京市")
    expect(location["city"]).to eq("北京市")
    expect(location["region"]).to eq("海淀区")

    latitude = "36.66"
    longitude = "101.76"

    location = baidu.get_location_from_coordinate(longitude, latitude)
    expect(location["province"]).to eq("青海省")
    expect(location["city"]).to eq("西宁市")
    expect(location["region"]).to eq("城北区")
  end

  it "get coordinate from string" do
    result = baidu.get_coordinate_from_string("思南路115弄")
    expect(result[:longitude]).not_to be_empty
    expect(result[:latitude]).not_to be_empty

    result = baidu.get_coordinate_from_string("思南路115弄", "上海市")
   
    expect(result[:longitude]).not_to be_empty
    expect(result[:latitude]).not_to be_empty

    result = baidu.get_coordinate_from_string("")
    
    expect(result).to eq(nil)

  end
end