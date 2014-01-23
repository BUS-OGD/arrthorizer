require "spec_helper"

describe Arrthorizer::Privilege do
  describe :get do
    context "when the privilege set does not exist" do
      it "raises a Privilege::NotFound error" do
        expect {
          Arrthorizer::Privilege.get("computer_says_no")
        }.to raise_error(Arrthorizer::Repository::NotFound)
      end
    end

    context "when the privilege set with the given name exists" do
      let(:name) { "computer_says_hi" }

      before do
        @privilege = Arrthorizer::Privilege.new(name)
      end

      it "returns that privilege set" do
        Arrthorizer::Privilege.get(name).should be @privilege
      end
    end

    context "when the parameter is already a privilege set" do
      before do
        @privilege = Arrthorizer::Privilege.new("irrelevant")
      end

      specify "that privilege set is returned" do
        Arrthorizer::Privilege.get(@privilege).should be @privilege
      end
    end
  end
end
