class HomeController < ActionController::Base
  # I'm not sure why I need to specify the layout here. I believed
  # that it was autoloaded if it was present. Must miss something
  # in either the header from the tests or in the configurations.
  layout 'application'
end
