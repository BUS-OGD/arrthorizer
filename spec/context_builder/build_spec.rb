require "spec_helper"

describe Arrthorizer::ContextBuilder do
  let(:builder) { Arrthorizer::ContextBuilder.new do end }

  describe :build do
    it "returns an Arrthorizer::Context" do
      expect(builder.build).to be_an Arrthorizer::Context
    end
  end
end

