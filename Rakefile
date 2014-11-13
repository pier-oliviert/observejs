require "bundler/gem_tasks"
require_relative "test/test_helper"
require 'rake/testtask'
require 'rails/test_unit/sub_test_task'

task default: :test

desc 'Runs all test'
task :test do
    Rails::TestTask.test_creator(Rake.application.top_level_tasks).invoke_rake_task
end

namespace :test do

  task run: %w(railtie)

  Rails::TestTask.new(:railtie) do |t|
    t.pattern = "test/integration/railtie/**/*_test.rb"
  end
end

desc 'A thin rails server instance for development and testing'
task :server do

  opts = {
    app: Ethereal::Application,
    Port: 3000
  }

  Rack::Server.start(opts)

end
