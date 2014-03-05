require "spec_helper"

# explicitly require the right file since
# Context() is not an autoloaded constant
require "arrthorizer/context"

describe Arrthorizer do
  describe 'Context()' do
    let(:key) { 'key' }
    let(:value) { 'value' }
    let(:arg) { Object.new }

    context "when an object that does not support #to_hash is provided" do
      it "raises an Arrthorizer::ContextConversionError" do
        expect {
          Arrthorizer::Context(arg)
        }.to raise_error(Arrthorizer::Context::ConversionError)
      end
    end

    context "when an object responding to #to_hash is provided" do
      before :each do
        arg.stub(:to_hash).and_return({ key => value })
      end

      it "returns an Arrthorizer::Context" do
        result = Arrthorizer::Context(arg)

        expect(result).to be_an Arrthorizer::Context
      end

      describe "the returned Arrthorizer::Context" do
        let(:result) { Arrthorizer::Context(arg) }

        specify "it contains the same key-value pairs" do
          expect(result.send(key)).to eql(value)
        end
      end
    end

    context "when an Arrthorizer::Context is provided" do
      let(:param) { Arrthorizer::Context.new }

      specify "that context is returned unmodified" do
        expect(Arrthorizer::Context(param)).to be(param)
      end
    end
  end
end
