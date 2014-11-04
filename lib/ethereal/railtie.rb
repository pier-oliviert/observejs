module Ethereal
  class Railtie < Rails::Railtie
    initializer 'ethereal.assets.paths', before: :add_view_paths do |app|
      ethereal_assets_path = File.dirname(__FILE__) + '/app/assets/'
      app.paths['vendor/assets'] << ethereal_assets_path
      app.config.assets.precompile << ethereal_assets_path

      app.paths['app/views'] << File.dirname(__FILE__) + '/app/views/'
    end
  end
end
