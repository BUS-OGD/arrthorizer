require 'rspec/expectations'

module Arrthorizer
  module RSpec
    autoload :Matchers,   'arrthorizer/rspec/matchers'
  end

  ::RSpec.configure do |config|
    config.include Arrthorizer::RSpec::Matchers::Roles, {
      type: :role,
      example_group: { file_path: %r(spec/roles) }
    }
  end
end


