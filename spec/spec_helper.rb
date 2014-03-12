require 'rubygems'
require 'bundler/setup'

require 'combustion'

Combustion.initialize! :active_record, :action_controller,
                       :action_view

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
