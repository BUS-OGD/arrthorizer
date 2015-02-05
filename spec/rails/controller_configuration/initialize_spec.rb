require "rails_helper"

describe Arrthorizer::Rails::ControllerConfiguration do
  describe :initialize do
    it "yields the new instance to the builder block" do
      expect { |block|
        Arrthorizer::Rails::ControllerConfiguration.new(&block)
      }.to yield_with_args(an_instance_of(Arrthorizer::Rails::ControllerConfiguration))
    end

    context "when no builder block is provided" do
      specify "an Arrthorizer::Rails::ControllerConfiguration::Error is raised" do
        expect {
          Arrthorizer::Rails::ControllerConfiguration.new
        }.to raise_error(Arrthorizer::Rails::ControllerConfiguration::Error)
      end
    end
  end
end
