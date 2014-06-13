# GeoApi

位置接口,目前调用百度地理位置api获取格式化的地理位置数据.

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