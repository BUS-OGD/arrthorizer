require 'rubygems'
require 'bundler/setup'

ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require 'rspec/rails'

Dir.glob('./spec/support/**/*.rb') do |file|
  require file
end

Dir.glob('./spec/fixtures/**/*.rb') do |file|
  require file
end

RSpec.configure do |config|
  config.use_transactional_fixtures = true

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
