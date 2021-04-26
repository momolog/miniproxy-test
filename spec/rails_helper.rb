require 'spec_helper'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'

# Add additional requires below this line. Rails is not loaded until this point!

require 'capybara/rspec'
require 'capybara/rails'

require "selenium/webdriver"

require 'evil-proxy'
require 'evil-proxy/selenium'

trap "INT"  do proxy.shutdown end
trap "TERM" do proxy.shutdown end

proxy = EvilProxy::HTTPProxyServer.new Port: 8080
proxy.start

proxy.before_request do |req|
  # Do evil things
  # Note that, different from Webrick::HTTPProxyServer, 
  #   `req.body` is writable.
  p "######### request"
  p req
  p "#########"
end

proxy.before_response do |req, res|
  p "######### response"
  p res
  p "#########"
  res.body = 'You have been hacked'
end

Capybara.register_driver :chrome do |app|

  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    "goog:chromeOptions": {
      args: ["ignore-certificate-errors", "disable-web-security", "proxy-server=127.0.0.1:8080"]
    }
  )
  Capybara::Selenium::Driver.new(app,
    browser: :chrome,
    desired_capabilities: capabilities
  )
end

Capybara.javascript_driver = :chrome
