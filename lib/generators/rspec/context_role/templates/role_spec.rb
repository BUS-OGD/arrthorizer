require 'spec_helper'

describe <%= class_name %> do
  subject(:role) { <%= class_name %> }

  let(:user) { double(:user) }

  let(:current_context) { { } }

  describe :applies_to_user? do
    context "when some_condition" do
      before :each do
        # TODO: Add the required elements to the current_context
        # to make the ContextRole apply to the user
      end

      it "returns true" do
        pending

        expect(role).to apply_to_user(user).with_context(current_context)
      end

      # This is an extremely important test - it safeguards against
      # persisting data between requests.
      specify "no state is maintained in the role object" do
        role.applies_to_user?(user, Arrthorizer::Context(current_context))

        expect(role.instance.instance_variables).to be_empty
      end
    end

    context "when some_other_condition" do
      before :each do
        # TODO: Add the required elements to the current_context
        # to make the ContextRole *not* apply to the user
      end

      it "returns false" do
        pending

        expect(role).not_to apply_to_user(user).with_context(current_context)
      end

      # This is an extremely important test - it safeguards against
      # persisting data between requests.
      specify "no state is maintained in the role object" do
        role.applies_to_user?(user, Arrthorizer::Context(current_context))

        expect(role.instance.instance_variables).to be_empty
      end
    end
  end
end
