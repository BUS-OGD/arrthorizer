require "spec_helper"

describe Arrthorizer::ContextBuilder do
  let(:builder) { Arrthorizer::ContextBuilder.new do end }

  describe :build do
    it "returns an Arrthorizer::Context" do
      builder.build.should be_an Arrthorizer::Context
    end
  end
end

