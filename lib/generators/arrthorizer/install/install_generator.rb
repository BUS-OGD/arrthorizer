module Arrthorizer
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      def create_roles_dir
        create_file gitkeep_for(roles_dir), ''
      end

      def create_config_file
        copy_file "config.yml", "config/arrthorizer.yml"
      end

      def activate_filter
        insert_into_file 'app/controllers/application_controller.rb', filter_code, after: /class ApplicationController.*$/
        insert_into_file 'app/controllers/application_controller.rb', context_preparation_code, before: /end$\s*\z/
      end

    protected
      def filter_code
        <<-FILTER_CODE

  # Activate Arrthorizer's authorization checks for each
  # request to this controller's actions
  requires_authorization
        FILTER_CODE
      end

      def context_preparation_code
        <<-PREPARATION_CODE

  # By default, configure Arrthorizer to provide all params,
  # except for :controller and :action, as context to all
  # ContextRoles.
  to_prepare_context do |c|
    c.defaults do
      # this block must return a Hash-like object. It is
      # advisable to put actual objects in this hash instead
      # of ids and such. The block is executed within the
      # controller, so all methods defined on the controller
      # are available in this block.
      params.except(:controller, :action)
    end

    # for specific actions, additional context can be defined
    # c.for_action(:new) do
    #   arrthorizer_defaults.merge(key: 'value')
    # end
  end
        PREPARATION_CODE
      end

      def gitkeep_for(directory)
        directory.join('.gitkeep')
      end

      def roles_dir
        ::Rails.root.join('app', 'roles')
      end
    end
  end
end
