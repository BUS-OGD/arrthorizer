require "spec_helper"

describe Arrthorizer::Privilege do
  subject(:privilege) { Arrthorizer::Privilege.new(name: "some privilege") }

  let(:role) { SomeGenericRole }
  let(:other_role) { AnotherGenericRole }

  describe :accessible_to? do
    context "when a Role was configured to have access to this privilege" do
      before :each do
        privilege.make_accessible_to(role)
      end

      context "and that Role is provided" do
        let(:arg) { role }

        it "returns true" do
          expect(privilege.accessible_to?(arg)).to be_true
        end
      end

      context "and the name of that Role is provided" do
        let(:arg) { role.name }

        it "returns true" do
          expect(privilege.accessible_to?(arg)).to be_true
        end
      end
    end
  end
end
