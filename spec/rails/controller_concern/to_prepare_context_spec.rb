require "spec_helper"

describe Arrthorizer::Rails::ControllerConcern do
  describe :to_prepare_context do
    let(:controller_class) { Class.new(ApplicationController) }
    let(:expected_controller_configuration_type) { Arrthorizer::Rails::ControllerConfiguration }

    it "adds a ControllerConfiguration to the class" do
      expected_controller_configuration = an_instance_of(expected_controller_configuration_type)

      expect {
        controller_class.to_prepare_context do end
      }.to change { controller_class.arrthorizer_configuration }.to(expected_controller_configuration)
    end

    context "when we are dealing with a subclassed controller" do
      let(:controller_subclass) { Class.new(controller_class) }

      before :each do
        controller_class.to_prepare_context do end
      end

      it "does not alter the context config for the superclass" do
        expect {
          controller_subclass.to_prepare_context do end
        }.not_to change { controller_class.arrthorizer_configuration }
      end
    end

    context "when no configuration block is provided" do
      specify "an Arrthorizer::Rails::ControllerConfiguration::Error is raised" do
        expect {
          controller_class.to_prepare_context
        }.to raise_error(Arrthorizer::Rails::ControllerConfiguration::Error)
      end
    end
  end
end
