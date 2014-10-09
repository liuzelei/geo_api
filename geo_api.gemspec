# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'geo_api/version'

Gem::Specification.new do |spec|
  spec.name          = "geo_api"
  spec.version       = GeoApi::VERSION
  spec.authors       = ["liuzelei"]
  spec.email         = ["liuzelei@gmail.com"]
  spec.description   = '基础地理位置服务'
  spec.summary       = '提供字符串解析,经纬度解析映射等'
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"

  spec.add_runtime_dependency "bson"
  spec.add_runtime_dependency "mongoid"
end
