module Ethereal
  class Railtie < Rails::Railtie
    initializer 'ethereal.assets.paths', before: :add_view_paths do |app|
      app.paths['vendor/assets'] << File.dirname(__FILE__) + '/app/assets/'
      app.paths['app/views'] << File.dirname(__FILE__) + '/app/views/'
    end
  end
end
