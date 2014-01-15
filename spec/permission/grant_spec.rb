require "spec_helper"

describe Arrthorizer::Permission do
  describe :grant do
    let(:privilege_set) { Arrthorizer::PrivilegeSet.new("privilege_set") }
    let(:role) { Arrthorizer::GenericRole.new("role") }

    it "adds the role to the privilege set" do
      privilege_set.should_receive(:make_accessible_to).with(role)

      Arrthorizer::Permission.grant(privilege_set, to: role)
    end
  end
end
