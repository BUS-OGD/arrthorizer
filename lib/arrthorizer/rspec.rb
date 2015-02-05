require 'rspec/core/version'
require 'rspec/expectations'

module Arrthorizer
  module RSpec
    autoload :Matchers,       'arrthorizer/rspec/matchers'
    autoload :SharedExamples, 'arrthorizer/rspec/shared_examples'
  end

  role_spec = {
    type: :role,
  }

  example_group_spec = {
    file_path: %r(spec/roles)
  }

  if ::RSpec::Core::Version::STRING =~ /\A2/
    role_spec[:example_group] = example_group_spec
  else
    role_spec.merge!(example_group_spec)
  end

  ::RSpec.configure do |config|
    config.include Arrthorizer::RSpec::Matchers::Roles, role_spec
    config.include Arrthorizer::RSpec::SharedExamples, role_spec
  end
end


