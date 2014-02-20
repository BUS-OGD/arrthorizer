require "spec_helper"

describe Arrthorizer::Group do
  describe :initialize do
    it "registers the new instance with Role" do
      role = Arrthorizer::Group.new("some new group")

      Arrthorizer::Role.get(role).should == role
    end
  end
end
