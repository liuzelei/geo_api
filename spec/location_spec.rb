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

    location = GeoApi::Location.get_location_by_string(location_str)

    location.should == databack
  end

  it "should get location by coordinate" do
    latitude = "39.983424"
    longitude = "116.322987"

    databack = Hash.new
    databack["province"] = "北京市"
    databack["city"] = "北京市"
    databack["region"] = "海淀区" 
    databack["detail"] = "中关村大街27号1101-08室"
    databack["latitude"] = "39.983424051248"
    databack["longitude"] = "116.32298703399"

    location = GeoApi::Location.get_location_by_coordinate(latitude,longitude)

    location.should == databack
  end
end