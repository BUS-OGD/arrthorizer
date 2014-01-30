module Arrthorizer
  module Rails
    class ControllerConfiguration
      Error = Class.new(Arrthorizer::ArrthorizerException)

      def initialize(&block)
        yield self
      rescue LocalJumpError
        raise Error, "No builder block provided to ContextBuilder.new"
      end

      def defaults(&block)
        self.defaults_block = block
      end

      def for_action(action, &block)
        add_action_block(action, &block)
      end

      def block_for(action)
        action_blocks.fetch(action) { defaults_block }
      end

    private
      attr_accessor :defaults_block

      def add_action_block(action, &block)
        action_blocks[action] = block
      end

      def action_blocks
        @action_blocks ||= HashWithIndifferentAccess.new
      end
    end
  end
end
