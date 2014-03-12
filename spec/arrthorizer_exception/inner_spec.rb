require "spec_helper"

describe Arrthorizer::ArrthorizerException do
  describe :inner do
    let(:inner_exception) { Class.new(StandardError).new }

    context "when an ArrthorizerException is raised from a rescue block" do
      it "wraps the rescued exception and exposes it via the #inner method" do
        begin
          raise inner_exception
        rescue
          begin
            raise Arrthorizer::ArrthorizerException
          rescue Exception => e
            expect(e.inner).to be inner_exception
          end
        end
      end
    end
  end
end
