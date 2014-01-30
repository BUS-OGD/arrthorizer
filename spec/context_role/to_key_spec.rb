require 'spec_helper'

describe Arrthorizer::ContextRole do
  describe :to_key do
    context "when the context role is not namespaced" do
      let(:role) { UnnamespacedContextRole.instance }

      it "returns a snake_cased version of the class name" do
        expect(role.to_key).to eql "unnamespaced_context_role"
      end
    end

    context "when the context role is namespaced" do
      let(:role) { Namespaced::ContextRole.instance }

      it "returns a snake_cased version of the class name" do
        expect(role.to_key).to eql "namespaced/context_role"
      end
    end
  end
end
