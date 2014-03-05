require "spec_helper"

require 'arrthorizer/rails'

describe Arrthorizer::Rails do
  describe "controller integration" do
    let(:controller_class) { Class.new(ApplicationController) do def index; end end}

    describe "each controller class" do
      it "responds to :prepare_context" do
        expect(controller_class).to respond_to :to_prepare_context
      end

      it "responds to :arrthorizer_configuration" do
        expect(controller_class).to respond_to :arrthorizer_configuration
      end
    end

    describe "each controller" do
      let(:controller) { controller_class.new }

      it "has a protected method called :arrthorizer_context" do
        # this method is protected to prevent exposing it
        # via default or wildcard routes
        expect(controller.protected_methods).to include :arrthorizer_context
      end

      context "when it has a proper configuration for context building" do
        let(:injected_params) { { some_param: 1 } }
        let(:current_action) { 'some_action' }

        before :each do
          controller.stub(:params).and_return injected_params

          controller.stub(:action_name).and_return(current_action)
        end

        context "and there is no specific configuration for the current action" do
          before :each do
            controller_class.to_prepare_context do |c|
              c.defaults do
                params # this is an example config which can be easily tested
              end
            end
          end

          it "uses the 'default' config to build an Arrthorizer context" do
            context = controller.send(:arrthorizer_context)

            expect(context).to eql Arrthorizer::Context(injected_params)
          end
        end

        context "and there is a specific configuration for the current action" do
          let(:action_specific_config) { { some_extra_key: 'some_value' }}

          before :each do
            controller_class.to_prepare_context do |c|
              c.defaults do
                params
              end

              c.for_action(current_action) do
                arrthorizer_defaults.merge(some_extra_key: 'some_value')
              end
            end
          end

          it "uses the more specific configuration for the current action" do
            context_hash = injected_params.merge(action_specific_config)
            expected_context = Arrthorizer::Context(context_hash)

            context = controller.send(:arrthorizer_context)

            expect(context).to eql expected_context
          end
        end
      end
    end
  end
end
