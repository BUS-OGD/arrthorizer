require 'rspec/expectations'

module Arrthorizer
  module RSpec
    autoload :Matchers,       'arrthorizer/rspec/matchers'
    autoload :SharedExamples, 'arrthorizer/rspec/shared_examples'
  end

  role_spec = {
      type: :role,
      example_group: { file_path: %r(spec/roles) }
    }

  ::RSpec.configure do |config|
    config.include Arrthorizer::RSpec::Matchers::Roles, role_spec
    config.include Arrthorizer::RSpec::SharedExamples, role_spec
  end
end


