require "spec_helper"

describe Arrthorizer::PrivilegeSet do
  describe :get do
    context "when the privilege set does not exist" do
      it "raises a PrivilegeSet::NotFound error" do
        expect {
          Arrthorizer::PrivilegeSet.get("computer_says_no")
        }.to raise_error(Arrthorizer::Repository::NotFound)
      end
    end

    context "when the privilege set with the given name exists" do
      let(:name) { "computer_says_hi" }

      before do
        @privilege_set = Arrthorizer::PrivilegeSet.new(name)
      end

      it "returns that privilege set" do
        Arrthorizer::PrivilegeSet.get(name).should be @privilege_set
      end
    end

    context "when the parameter is already a privilege set" do
      before do
        @privilege_set = Arrthorizer::PrivilegeSet.new("irrelevant")
      end

      specify "that privilege set is returned" do
        Arrthorizer::PrivilegeSet.get(@privilege_set).should be @privilege_set
      end
    end
  end
end
