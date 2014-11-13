ENV['RAILS_ENV'] ||= 'test'
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])
require 'rails/all'

Bundler.require(:default, Rails.env)

require "bundler/gem_tasks"
require 'rake/testtask'
require 'rails/test_unit/sub_test_task'

task default: :test

desc 'Runs all test'
task :test do
  Rails::TestTask.test_creator(Rake.application.top_level_tasks).invoke_rake_task
end

namespace :test do

  task run: %w(helpers railtie)

  task :helpers do
    require_relative "test/test_helper"
  end

  Rails::TestTask.new(:railtie) do |t|
    t.pattern = "test/integration/railtie/**/*_test.rb"
  end
end

desc 'A thin rails server instance for development and testing'
task :server do
  require_relative "test/application"

  opts = {
    app: Ethereal::Application.initialize!,
    Port: 3000
  }

  Rack::Server.start(opts)

end
