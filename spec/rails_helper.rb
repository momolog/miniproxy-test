require 'spec_helper'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'

# Add additional requires below this line. Rails is not loaded until this point!

require 'capybara/rspec'
require 'capybara/rails'

require "selenium/webdriver"
require "miniproxy"

Capybara.register_driver :chrome do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    "goog:chromeOptions": {
      args: ["ignore-certificate-errors", "disable-web-security", "proxy-server=#{MiniProxy.host}:#{MiniProxy.port}"]
    }
  )
  Capybara::Selenium::Driver.new(app,
    browser: :chrome,
    desired_capabilities: capabilities
  )
end

Capybara.javascript_driver = :chrome
