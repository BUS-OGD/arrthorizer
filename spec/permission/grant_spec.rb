require "spec_helper"

describe Arrthorizer::Permission do
  describe :grant do
    let(:privilege) { Arrthorizer::Privilege.new(name: "privilege") }
    let(:role) { Arrthorizer::Group.new("role") }

    it "adds the role to the privilege set" do
      Arrthorizer::Permission.grant(privilege, to: role)

      expect(privilege).to be_accessible_to(role)
    end
  end
end
