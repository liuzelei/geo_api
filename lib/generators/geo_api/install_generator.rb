module GeoApi
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    def create_initializer_file
      template 'initializer.rb', 'config/initializers/geo_api.rb'
    end
  end
end