module Arrthorizer
  module Rails
    module ControllerConcern
      extend ActiveSupport::Concern

      included do
      protected
        class_attribute :arrthorizer_configuration, instance_writer: false

        ##
        # This is a hook method that provides access to the context for a
        # given HTTP request. For each request, an Arrthorizer::Context object is
        # built and provided to all ContextRoles that are configured as having
        # access to the given controller action.
        def arrthorizer_context
          arrthorizer_context_builder.build_for_action
        end

        def arrthorizer_defaults
          arrthorizer_context_builder.build_default
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

        def arrthorizer_context_builder
          @context_builder ||= Arrthorizer::Rails::ControllerContextBuilder.new(self, arrthorizer_configuration)
        end
      end

      module ClassMethods
        ##
        # This method sets up Arrthorizer to verify that a user has the proper
        # rights to access a # given controller action. Options can be provided
        # and are passed to before_filter.
        def requires_authorization(options = {})
          before_filter :authorize, options
        end

        ##
        # This method sets up Arrthorizer to not verify requests to all (when
        # no options are provided) or selected (when :only or :except are
        # provided) actions in this controller and its subclasses.
        # Options can be provided and are passed to skip_filter.
        def does_not_require_authorization(options = {})
          skip_filter :authorize, options
        end

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
