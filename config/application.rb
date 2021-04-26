require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
require 'csv'

# If you precompile assets before deploying to production, use this line
Bundler.require(*Rails.groups(:assets => %w(development test)))

module MiniProxyTest
  class Application < Rails::Application
  end
end
