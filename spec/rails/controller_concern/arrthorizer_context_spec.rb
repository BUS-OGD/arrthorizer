require "spec_helper"

describe Arrthorizer::Rails::ControllerConcern do
  let(:controller_class) { Class.new(SomeController) }
  let(:controller) { controller_class.new }

  before :each do
    controller_class.to_prepare_context do |c|
      c.defaults do
        params
      end
    end

    controller.stub(:request).and_return(ActionDispatch::TestRequest.new)
  end

  describe :arrthorizer_context do
    it "returns an Arrthorizer::Context" do
      context = controller.send(:arrthorizer_context)

      expect(context).to be_a Arrthorizer::Context
    end
  end
end
