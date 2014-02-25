require 'rspec/expectations'

module Arrthorizer
  module RSpec
    module Matchers
      module Roles
        class AppliesToUser
          def initialize(user)
            @user = user
          end

          def matches?(role)
            @role = role

            role.applies_to_user?(user, context)
          end

          def failure_message
            "Expected role #{@role.name} to apply in context #{context.inspect}\nfor user #{user.inspect}, but it does not apply!"
          end

          def negative_failure_message
            "Expected role #{@role.name} not to apply in context #{context.inspect}\nfor user #{user.inspect}, but it applies!"
          end

          def with_context(hash)
            @context = to_context(hash)

            self
          end

        protected
          attr_accessor :context, :user

          def to_context(context_hash)
            Arrthorizer::Context.new(context_hash)
          end
        end

        def apply_to_user(user, context = {})
          AppliesToUser.new(user).with_context(context)
        end
      end
    end
  end
end
