module Arrthorizer
  module Rails
    class ControllerAction
      ControllerNotDefined = Class.new(Arrthorizer::ArrthorizerException)
      ActionNotDefined = Class.new(Arrthorizer::ArrthorizerException)

      attr_accessor :privilege
      attr_reader :controller_name, :action_name

      def self.get_current(controller)
        fetch_by_name(name_for(controller))
      end

      def initialize(attrs)
        self.controller_name = attrs.fetch(:controller) { raise ControllerNotDefined }
        self.action_name = attrs.fetch(:action) { raise ActionNotDefined }

        self.class.register(self)
      end

      def name
        self.class.name_for(self)
      end

    private
      attr_writer :controller_name, :action_name

      def self.name_for(controller)
        "#{controller.controller_name}##{controller.action_name}"
      end

      def self.fetch_by_name(name)
        repository.fetch(name)
      end

      def self.register(controller_action)
        repository.add(controller_action)
      end

      def self.repository
        @repository ||= Repository.new
      end
    end
  end
end
