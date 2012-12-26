# Simplecov Setup
if RUBY_VERSION >= '1.9.2'
  require 'simplecov'
  require 'simplecov-rcov'
  SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter
  SimpleCov.start 'rails' do
    add_filter '/vendor/'
  end
end
# IMPORTANT: This file is generated by cucumber-rails - edit at your own peril.
# It is recommended to regenerate this file in the future when you upgrade to a 
# newer version of cucumber-rails. Consider adding your own code to a new file 
# instead of editing this one. Cucumber will automatically load all features/**/*.rb
# files.

ENV["RAILS_ENV"] ||= 'test'

require 'bundler'
Bundler.require :default, :development, :assets
$:.push(File.expand_path('../../../lib', __FILE__))
require 'xrono'
require 'combustion'
Combustion.initialize!

require 'cucumber'
require 'capybara'
require 'capybara/dsl'
require 'capybara/rspec/matchers'
require 'sidekiq/testing/inline'

World(Capybara::RSpecMatchers)
World(Capybara::DSL)
module RouteProxy
  # didn't find a cleaner way to get route helpers into my steps
  def method_missing(sym, *args)
    if route_helpers.respond_to?(sym)
      route_helpers.send(sym, *args)
    else
      super
    end
  end

  def route_helpers
    Rails.application.routes.url_helpers
  end
end

World(RouteProxy)
Before do
    Rails.application.routes.default_url_options[:host] = 'test.host'
end
# Capybara defaults to XPath selectors rather than Webrat's default of CSS3. In
# order to ease the transition to Capybara we set the default here. If you'd
# prefer to use XPath just remove this line and adjust any selectors in your
# steps to use the XPath syntax.
Capybara.default_selector = :css

# By default, any exception happening in your Rails application will bubble up
# to Cucumber so that your scenario will fail. This is a different from how 
# your application behaves in the production environment, where an error page will 
# be rendered instead.
#
# Sometimes we want to override this default behaviour and allow Rails to rescue
# exceptions and display an error page (just like when the app is running in production).
# Typical scenarios where you want to do this is when you test your error pages.
# There are two ways to allow Rails to rescue exceptions:
#
# 1) Tag your scenario (or feature) with @allow-rescue
#
# 2) Set the value below to true. Beware that doing this globally is not
# recommended as it will mask a lot of errors for you!
#
#ActionController::Base.allow_rescue = false
Capybara.app = Rails.application
Before("@javascript") do
  Capybara.current_driver = :selenium
end
After("@javascript") do
  Capybara.current_driver = Capybara.default_driver
end
