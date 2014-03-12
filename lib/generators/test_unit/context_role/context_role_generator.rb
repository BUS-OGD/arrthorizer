module TestUnit
  module Generators
    class ContextRoleGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('../templates', __FILE__)

      def unit_test
        template "role_test.rb", "test/roles/#{name}_test.rb"
      end
    end
  end
end
