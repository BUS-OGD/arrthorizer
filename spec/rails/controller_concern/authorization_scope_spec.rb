require 'rails_helper'

describe Arrthorizer::Rails::ControllerConcern do
  describe :authorization_scope do
    let(:controller) { SomeController.new }

    context "when no scope is explicitly configured" do
      specify "the default of :current_user is tried" do
        expect(controller).to receive(:current_user)

        controller.send(:arrthorizer_scope)
      end

      context "when a different scope is explicitly configured" do
        let(:controller_class) { Class.new(SomeController) }
        let(:controller)       { controller_class.new }

        before :each do
          controller_class.authorization_scope :some_other_method
        end

        specify "that scope is used for authorization" do
          expect(controller).to receive(:some_other_method)

          controller.send(:arrthorizer_scope)
        end
      end
    end
  end
end
