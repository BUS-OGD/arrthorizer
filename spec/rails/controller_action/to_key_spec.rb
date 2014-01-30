require "spec_helper"

describe Arrthorizer::Rails::ControllerAction do
  describe :to_key do
    let(:controller) { "forum/topics" }
    let(:action) { "create" }

    subject(:controller_action) { Arrthorizer::Rails::ControllerAction.new(controller: controller, action: action) }

    it "joins controller and action into a 'hash shorthand'" do
      expect(controller_action.to_key).to eql("#{controller}##{action}")
    end
  end
end
