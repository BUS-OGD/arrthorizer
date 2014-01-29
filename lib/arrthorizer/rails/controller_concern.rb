module Arrthorizer
  module Rails
    module ControllerConcern
      extend ActiveSupport::Concern

      included do
        class_attribute :arrthorizer_configuration, instance_writer: false

        ##
        # This is a hook method that provides access to the context for a
        # given HTTP request. For each request, an Arrthorizer::Context object is
        # built and provided to all ContextRoles that are configured as having
        # access to the given controller action.
        def arrthorizer_context
          arrthorizer_configuration.builder_for(self).build_for_action(action_name)
        end

        def arrthorizer_defaults
          arrthorizer_configuration.builder_for(self).build_for_action(nil)
        end

        def authorize
          action = Arrthorizer::Rails::ControllerAction.get_current(self)
          roles = action.privilege.permitted_roles

          roles.any? do |role|
            role.applies_to_user?(current_user, arrthorizer_context)
          end || forbidden
        end

        def forbidden
          render text: 'Access Denied', status: :forbidden
        end

        protected :arrthorizer_context, :arrthorizer_configuration, :arrthorizer_defaults
      end

      module ClassMethods
        ##
        # This is the configuration method for building Arrthorizer contexts from HTTP requests.
        # The developer specifies how contexts for authorization checks should be built
        # by providing a block to this method. For more information, check the documentation
        # on Arrthorizer::Rails::ControllerConfiguration
        def to_prepare_context(&block)
          self.arrthorizer_configuration = Arrthorizer::Rails::ControllerConfiguration.new(&block)
        end
      end
    end
  end
end
