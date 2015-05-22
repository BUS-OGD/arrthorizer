require "spec_helper"

describe Arrthorizer::Rails::ControllerConfiguration do
  let(:config) { Arrthorizer::Rails::ControllerConfiguration.new do end }

  describe :for_action do
    context "when multiple actions are provided" do
      let(:actions) { [:show, :index] }

      it "calls add_action_block with each of those actions" do
        actions.each do |action|
          expect(config).to receive(:add_action_block).with(action)
        end

        config.for_action *actions do
          {}
        end
      end
    end
  end
end
