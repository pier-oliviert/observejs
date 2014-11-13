# The order of this file is important as some requirements execute ruby code automatically.

ENV['RAILS_ENV'] ||= 'test'
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])
require_relative 'application'

Ethereal::Application.initialize!

require 'rails/test_help'

class ActiveSupport::TestCase
end

class ActionDispatch::IntegrationTest
  setup do
    @routes = Rails.application.routes
  end
end

