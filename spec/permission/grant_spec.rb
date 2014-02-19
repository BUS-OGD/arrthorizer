require "spec_helper"

describe Arrthorizer::Permission do
  describe :grant do
    let(:privilege) { Arrthorizer::Privilege.new(name: "privilege") }
    let(:role) { Arrthorizer::Group.new("role") }

    it "adds the role to the privilege set" do
      privilege.should_receive(:make_accessible_to).with(role)

      Arrthorizer::Permission.grant(privilege, to: role)
    end
  end
end
