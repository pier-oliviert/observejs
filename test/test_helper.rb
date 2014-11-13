# The order of this file is important as some requirements execute ruby code automatically.
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

