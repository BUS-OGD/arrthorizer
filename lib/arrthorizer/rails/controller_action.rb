module Arrthorizer
  module Rails
    class ControllerAction
      ControllerNotDefined = Class.new(Arrthorizer::ArrthorizerException)
      ActionNotDefined = Class.new(Arrthorizer::ArrthorizerException)

      attr_accessor :privilege
      attr_reader :controller_path, :action_name

      def self.get_current(controller)
        fetch(key_for(controller))
      end

      def initialize(attrs)
        self.controller_path = attrs.fetch(:controller) { raise ControllerNotDefined }
        self.action_name = attrs.fetch(:action) { raise ActionNotDefined }

        self.class.register(self)
      end

      def to_key
        "#{controller_path}##{action_name}"
      end

    private
      attr_writer :controller_path, :action_name

      def self.key_for(controller)
        "#{controller.controller_path}##{controller.action_name}"
      end

      def self.fetch(key)
        registry.fetch(key)
      end

      def self.register(controller_action)
        registry.add(controller_action)
      end

      def self.registry
        @registry ||= Registry.new
      end
    end
  end
end
