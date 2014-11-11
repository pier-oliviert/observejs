require 'rails/all'

Bundler.require(:default, Rails.env)

module Ethereal
  class Application < Rails::Application
    config.root = File.expand_path('../', __FILE__)
    config.eager_load = false
  end
end

