require "spec_helper"

describe Arrthorizer::GenericRole do
  describe :initialize do
    it "registers the new instance with Role" do
      role = Arrthorizer::GenericRole.new("generic role")

      Arrthorizer::Role.get(role).should == role
    end
  end
end
