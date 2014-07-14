# GeoApi

位置接口,目前调用百度地理位置api获取格式化的地理位置数据.

[![Travis](https://travis-ci.org/liuzelei/geo_api.svg?branch=master)](https://travis-ci.org/liuzelei/geo_api)
[![Code Climate](https://codeclimate.com/github/liuzelei/geo_api.png)](https://codeclimate.com/github/liuzelei/geo_api)
[![Coverage Status](https://coveralls.io/repos/liuzelei/geo_api/badge.png)](https://coveralls.io/r/liuzelei/geo_api)

## 安装

添加以下代码到Gemfile:

    gem 'geo_api', git: 'git@github.com:liuzelei/geo_api.git', tag: 'v0.0.5'

配置代码:
	
	GeoApi.setup do |config|
  		config.server = "http://api.map.baidu.com/geocoder/v2/"
  		config.key = "" #百度api的key
	end

## 使用

#### 获取某个字符串的格式化地址信息

	GeoApi.LocationService.instance.get_location_from_string("中山公园上海")

#### 获取某个经纬度下的格式化地址信息
	
	GeoApi.LocationService.instance.get_location_from_coordinate(12.34, 56.78, "bd09ll")
	
地址的格式化结果是

   	databack["province"] = "上海市"
    databack["city"] = "上海市"
    databack["region"] = "浦东新区" 
    databack["detail"] = "灵岩路79弄-1号"
    databack["latitude"] = "31.172419183453"
    databack["longitude"] = "121.50055678999"