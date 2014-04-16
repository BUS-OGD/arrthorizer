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
      # if you want to rename the 'role' or 'current_context' variables,
      # you can call this shared example with different options like so:
      # it_behaves_like "not persisting state in the role object", role: some_role, current_context: some_context
      it_behaves_like "not persisting state in the role object"
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
      # if you want to rename the 'role' or 'current_context' variables,
      # you can call this shared example with different options like so:
      # it_behaves_like "not persisting state in the role object", role: some_role, current_context: some_context
      it_behaves_like "not persisting state in the role object"
    end
  end
end
