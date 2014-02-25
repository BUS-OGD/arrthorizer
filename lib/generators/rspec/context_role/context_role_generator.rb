module Rspec
  module Generators
    class ContextRoleGenerator < ::Rails::Generators::NamedBase
      source_root File.expand_path('../templates', __FILE__)

      def unit_test
        template "role_spec.rb", "spec/roles/#{name}_spec.rb"
      end
    end
  end
end
