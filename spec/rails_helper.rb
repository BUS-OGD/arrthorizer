require 'rubygems'
require 'bundler/setup'

ENV["RAILS_ENV"] = "test"
require File.expand_path("../dummy/config/environment.rb",  __FILE__)

require 'rspec/rails'

require 'spec_helper'

# if normal specs run before Rails-related specs,
# the Arrthorizer::Rails component might not be initialized
# Therefore, we initialize it by hand
Arrthorizer::Rails.initialize!

Dir.glob('./spec/support/**/*.rb') do |file|
  require file
end

Dir.glob('./spec/fixtures/**/*.rb') do |file|
  require file
end

RSpec.configure do |config|
  config.use_transactional_fixtures = true
end

