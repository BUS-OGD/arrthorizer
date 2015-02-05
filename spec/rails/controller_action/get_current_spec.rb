require 'rails_helper'

describe Arrthorizer::Rails::ControllerAction do
  describe :get_current do
    let(:controller) { double('controller') }

    before :each do
      allow(Arrthorizer::Rails::ControllerAction).to receive(:key_for).with(controller).and_return("controller#action")
    end

    context "when there is no configuration for the current action" do
      let(:expected_error) { Arrthorizer::Rails::ControllerAction::ActionNotConfigured }

      specify "an ActionNotConfigured exception is raised" do
        expect {
          Arrthorizer::Rails::ControllerAction.get_current(controller)
        }.to raise_error(expected_error)
      end
    end
  end
end
