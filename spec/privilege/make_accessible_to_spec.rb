require "spec_helper"

describe Arrthorizer::Privilege do
  describe :make_accessible_to do
    let(:privilege) { Arrthorizer::Privilege.new(name: "privilege") }
    let(:role) { GenericRoleFixture }

    it "makes the privilege accessible to the role" do
      expect {
        privilege.make_accessible_to(role)
      }.to change { privilege.accessible_to?(role) }.to(true)
    end

    it "does not make it accessible to a different role" do
      unrelated_role = Arrthorizer::GenericRole.new("unrelated role")

      expect {
        privilege.make_accessible_to(role)
      }.not_to change { privilege.accessible_to?(unrelated_role) }.to(true)
    end
  end
end
