require 'spec_helper'

describe "test gaode" do
  let(:config) do
    config = GeoApi::Configuration.new
    config.server = 'http://restapi.amap.com/v3/geocode/'
    config.key = 'fc37e6da72d246a47034e05baa6464c6'
    config.vendor = 'GAODE'
    config
  end
  let(:gaode) { GeoApi::Gaode.new(config) }

  it "get location by coordinate" do
    latitude = "39.9834"
    longitude = "116.3229"

    location = gaode.get_location_from_coordinate(longitude, latitude)
    expect(location["province"]).to eq("北京市")
    expect(location["city"]).to eq("北京市")
    expect(location["region"]).to eq("海淀区")

    latitude = "36.66"
    longitude = "101.76"

    location = gaode.get_location_from_coordinate(longitude, latitude)
    expect(location["province"]).to eq("青海省")
    expect(location["city"]).to eq("西宁市")
    expect(location["region"]).to eq("城北区")
  end

  it "get coordinate from string" do
    result = gaode.get_coordinate_from_string("思南路115弄")
    expect(result[:longitude]).not_to be_empty
    expect(result[:latitude]).not_to be_empty

    result = gaode.get_coordinate_from_string("思南路115弄", "上海市")
   
    expect(result[:longitude]).not_to be_empty
    expect(result[:latitude]).not_to be_empty

    result = gaode.get_coordinate_from_string("")
    
    expect(result).to eq(nil)

  end
end