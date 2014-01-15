require "spec_helper"

describe Arrthorizer::PrivilegeSet do
  describe :make_accessible_to do
    let(:privilege_set) { Arrthorizer::PrivilegeSet.new("privilege set") }
    let(:role) { Arrthorizer::GenericRole.new("role") }

    it "makes the privilege_set accessible to the role" do
      expect {
        privilege_set.make_accessible_to(role)
      }.to change { privilege_set.accessible_to?(role) }.to(true)
    end

    it "does not make it accessible to a different role" do
      unrelated_role = Arrthorizer::GenericRole.new("unrelated role")

      expect {
        privilege_set.make_accessible_to(role)
      }.not_to change { privilege_set.accessible_to?(unrelated_role) }.to(true)
    end
  end
end
