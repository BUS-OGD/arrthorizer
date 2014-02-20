require "spec_helper"

describe Arrthorizer::Privilege do
  describe :initialize do
    let(:role) { SomeGroup }
    let(:roles) { [ role ] }
    let(:name) { "some name" }

    subject(:privilege) { Arrthorizer::Privilege.new(name: name, roles: roles) }

    it "makes itself accessible to each provided role" do
      expect(privilege).to be_accessible_to(role)
    end
  end
end
