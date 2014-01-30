require "spec_helper"

describe Arrthorizer::Registry do
  subject(:registry) { Arrthorizer::Registry.new }

  context "when the requested value is not in the Registry" do
    context "and no default value was specified" do
      it "raises an Arrthorizer::Registry::NotFound" do
        expect {
          registry.fetch("some_value")
        }.to raise_error(Arrthorizer::Registry::NotFound)
      end
    end

    context "and a default value was specified" do
      subject(:registry) { Arrthorizer::Registry.new }
      let(:default) { :default }

      it "returns the default" do
        actual = registry.fetch("some_value") { default }
        expect(actual).to eq(default)
      end
    end
  end
end
