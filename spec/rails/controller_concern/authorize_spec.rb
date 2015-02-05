require 'rails_helper'

describe Arrthorizer::Rails::ControllerConcern do
  let(:controller_class) { Class.new(SomeController) }
  let(:controller) { controller_class.new }
  let(:controller_action){ Arrthorizer::Rails::ControllerAction.new(controller: controller_path, action: action_name)}

  let(:action_name){ "some_action" }
  let(:controller_path){ "some" }
  let(:current_user){ double("user") }
  let(:context){ double("context") }

  before do
    allow(controller).to receive(:action_name).and_return(action_name)
    allow(controller).to receive(:current_user).and_return(current_user)
    allow(controller).to receive(:arrthorizer_context).and_return(context)
    allow(controller).to receive(:controller_path).and_return(controller_path)
  end

  describe :authorize do
    context "when no privilege has been defined for the action" do
      it "is forbidden" do
        expect(controller).to receive(:forbidden)

        controller.send(:authorize)
      end
    end

    context "when a privilege has been defined for the action" do
      let(:privilege){ Arrthorizer::Privilege.new(name: "test privilege") }
      let(:permitted_roles){ Arrthorizer::Registry.new }

      before do
        allow(controller_action).to receive(:privilege).and_return(privilege)
        allow(privilege).to receive(:permitted_roles).and_return(permitted_roles)
      end

      context "but the privilege has no permitted roles" do
        it "is forbidden" do
          expect(controller).to receive(:forbidden)

          controller.send(:authorize)
        end
      end

      context "and the privilege has a permitted role"  do
        let(:role){ Arrthorizer::Role.new }

        before do
          allow(role).to receive(:name).and_return('some_role')
          permitted_roles.add(role)
        end

        context "but building the context results in an error" do
          let(:error) { Class.new(StandardError).new }

          before :each do
            allow(controller).to receive(:arrthorizer_context).and_raise(error)
            # for testing purposes. We're testing a filter here, so no request exists, causing #status= to fail
            allow(controller).to receive(:forbidden)
          end

          specify "that error not suppressed" do
            expect {
              controller.send(:authorize)
            }.to raise_error(error)
          end
        end

        context "and the role applies to the user" do
          before do
            allow(role).to receive(:applies_to_user?).with(current_user, context).and_return(true)
          end

          it "is not forbidden" do
            expect(controller).not_to receive(:forbidden)

            controller.send(:authorize)
          end
        end

        context "and the role does not apply to the user" do
          before do
            allow(role).to receive(:applies_to_user?).with(current_user, context).and_return(false)
          end

          it "is forbidden" do
            expect(controller).to receive(:forbidden)

            controller.send(:authorize)
          end

          context "when the privilege has another permitted role" do
            let(:another_role){ Arrthorizer::Role.new }

            before do
              allow(another_role).to receive(:name).and_return('another_role')
              permitted_roles.add(another_role)
            end

            context "and the role applies to the user" do
              before do
                allow(another_role).to receive(:applies_to_user?).with(current_user, context).and_return(true)
              end

              it "is not forbidden" do
                expect(controller).not_to receive(:forbidden)

                controller.send(:authorize)
              end
            end

            context "and the role does not apply to the user" do
              before do
                allow(another_role).to receive(:applies_to_user?).with(current_user, context).and_return(false)
              end

              it "is forbidden" do
                expect(controller).to receive(:forbidden)

                controller.send(:authorize)
              end
            end
          end
        end

        context "but evaluating the role raises any kind of StandardError" do
          before do
            allow(role).to receive(:applies_to_user?).with(current_user, context).and_raise("Some exception")
          end

          specify "a warning is logged" do
            # for testing purposes. We're testing a filter here, so no request exists, causing #status= to fail
            allow(controller).to receive(:forbidden)

            expect(::Rails.logger).to receive(:warn).with(an_instance_of(String))

            controller.send(:authorize)
          end

          context "but more roles are provided access" do
            let(:another_role){ Arrthorizer::Group.new("some other role") }

            before :each do
              allow(another_role).to receive(:applies_to_user?).and_return(true)
              permitted_roles.add(another_role)
            end

            specify "those roles are checked next" do
              expect(another_role).to receive(:applies_to_user?)

              controller.send(:authorize)
            end
          end

          context "and no other roles are provided access" do
            specify "a #forbidden handler is triggered" do
              expect(controller).to receive(:forbidden)

              controller.send(:authorize)
            end
          end
        end
      end
    end
  end
end
