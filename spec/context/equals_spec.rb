require "spec_helper"

describe Arrthorizer::Context do
  let(:context_hash) { { some_key: 'some_value' } }
  let(:context) { Arrthorizer::Context.new(context_hash) }

  describe :== do
    context "when an Arrthorizer::Context is provided" do
      context "and that context has the same contents" do
        let(:other) { Arrthorizer::Context.new(context_hash) }

        it "returns true" do
          expect(context).to eq(other)
        end
      end

      context "but that context has different contents" do
        let(:other) { Arrthorizer::Context.new(some_key: 'other_value') }

        it "returns false" do
          expect(context).not_to eq(other)
        end
      end
    end

    context "when a hashlike object is provided" do
      context "and that object has the same contents" do
        let(:other) { context_hash.dup }

        it "returns true" do
          expect(context).to eq(other)
        end
      end

      context "but that object has different contents" do
        let(:other) { { some_key: 'some_other_value' } }

        it "returns false" do
          expect(context).not_to eq(other)
        end
      end
    end
  end
end
