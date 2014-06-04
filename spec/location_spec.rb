# encoding: utf-8
require 'spec_helper'

describe "test location" do
  it "should get location by string" do
    location = GeoApi::Location.instance.get_location_from_string("上海灵岩路79弄1号")
    location["province"].should == "上海市"
    location["city"].should == "上海市"
    location["region"].should == "浦东新区"

    location = GeoApi::Location.instance.get_location_from_string("")
    location.should == ""


    location = GeoApi::Location.instance.get_location_from_string("小桥大街西宁")
    location["province"].should == "青海省"
    location["city"].should == "西宁市"
    location["region"].should == "城北区"
  end

  it "should get location by coordinate" do
    latitude = "39.9834"
    longitude = "116.3229"

    location = GeoApi::Location.instance.get_location_from_coordinate(latitude, longitude)
    location["province"].should == "北京市"
    location["city"].should == "北京市"
    location["region"].should == "海淀区"

    latitude = "36.66"
    longitude = "101.76"

    location = GeoApi::Location.instance.get_location_from_coordinate(latitude, longitude)
    location["province"].should == "青海省"
    location["city"].should == "西宁市"
    location["region"].should == "城北区"
  end
end