module Arrthorizer
  module Rails
    class ControllerContextBuilder < Arrthorizer::ContextBuilder
      attr_accessor :controller, :configuration

      def initialize(controller, configuration)
        self.controller = controller
        self.configuration = configuration
      end

      def build_default
        config = config_for_action(nil)

        build_from_block(&config)
      end

      def build_for_action
        config = config_for_action(controller.action_name)

        build_from_block(&config)
      end

    protected
      def build_from_block(&config)
        if block_given?
          context_hash = controller.instance_eval(&config)

          build_from_hash(context_hash)
        else
          build_from_hash({})
        end
      end

      def config_for_action(action)
        configuration.try(:block_for, action)
      end
    end
  end
end
