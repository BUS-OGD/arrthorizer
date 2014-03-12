require "spec_helper"

describe Arrthorizer::Context do
  describe :merge do
    let(:base_hash) { { key: 'value' } }
    let(:base_context) { Arrthorizer::Context.new(base_hash) }
    let(:other_hash) { { other_key: 'other_value' } }
    let(:merged_hash) { base_hash.merge(other_hash) }

    shared_examples_for "the return value of Arrthorizer::Context#merge" do
      it "returns an Arrthorizer::Context" do
        expect(result).to be_an Arrthorizer::Context
      end

      describe "the returned Arrthorizer::Context" do
        it "contains the merged contents" do
          merged_hash.each_pair do |key, value|
            expect(result.send(key)).to eql value
          end
        end
      end
    end

    context "when another Arrthorizer::Context is provided" do
      let(:other_context) { Arrthorizer::Context.new(other_hash) }
      let(:result) { base_context.merge(other_context) }

      include_examples "the return value of Arrthorizer::Context#merge"
    end

    context "when a Hash is provided" do
      let(:result) { base_context.merge(other_hash) }

      include_examples "the return value of Arrthorizer::Context#merge"
    end
  end
end
