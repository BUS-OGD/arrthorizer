require "spec_helper"

describe Arrthorizer::Group do
  describe :initialize do
    it "registers the new instance with Role" do
      role = Arrthorizer::Group.new("some new group")

      expect(Arrthorizer::Role.get(role)).to eql role
    end
  end
end
