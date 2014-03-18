require "spec_helper"

describe Arrthorizer::Context do
  describe :initialize do
    context "when a Hash is provided" do
      let(:attributes) { { a: 2 } }

      it "copies the keys into the new Context object" do
        context = Arrthorizer::Context.new(attributes)

        expect(context.a).to eq 2
      end
    end

    context "when an OpenStruct is provided" do
      let(:attributes) { OpenStruct.new(a: 2) }

      it "copies the keys into the new Context object" do
        context = Arrthorizer::Context.new(attributes)

        expect(context.a).to eq 2
      end
    end

    context "when an Arrthorizer::Context is provided" do
      let(:attributes) { Arrthorizer::Context.new(a: 2) }

      it "copies the keys into the new Context object" do
        context = Arrthorizer::Context.new(attributes)

        expect(context.a).to eq 2
      end
    end
  end

  describe "DSL-style initialization" do
    context "when a Hash is provided" do
      let(:attributes) { { a: 2 } }

      it "copies the keys into the new Context object" do
        context = Arrthorizer::Context(attributes)

        expect(context.a).to eq 2
      end
    end

    context "when an OpenStruct is provided" do
      let(:attributes) { OpenStruct.new(a: 2) }

      it "copies the keys into the new Context object" do
        context = Arrthorizer::Context(attributes)

        expect(context.a).to eq 2
      end
    end

    context "when an Arrthorizer::Context is provided" do
      let(:attributes) { Arrthorizer::Context(a: 2) }

      it "copies the keys into the new Context object" do
        context = Arrthorizer::Context(attributes)

        expect(context.a).to eq 2
      end
    end
  end
end
