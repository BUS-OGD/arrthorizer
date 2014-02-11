require 'spec_helper'

describe SomeController do
  let(:action) { Arrthorizer::Rails::ControllerAction.fetch("some#some_action") }
  let(:other_action) { Arrthorizer::Rails::ControllerAction.fetch("some#other_action") }

  describe :some_action, type: :controller do
    let!(:privilege) { action.privilege }
    let!(:current_user) { double("user") }

    before do
      controller.stub(:current_user) { current_user }
    end

    describe "generic roles" do
      let!(:generic_role) { create_generic_role }

      context "when the role is linked to the privilege" do
        before do
          Arrthorizer::Permission.grant(privilege, to: generic_role)
        end

        context "when I am a member of the required generic role" do
          before do
            add_user_to_generic_role(current_user, generic_role)
          end

          it "succeeds" do
            get :some_action

            response.should be_success
          end
        end

        context "when I am not a member of the required generic role" do
          it "fails" do
            get :some_action

            response.should be_forbidden
          end
        end
      end

      context "when I am only a member of an unrelated generic role" do
        before do
          other_privilege = other_action.privilege
          Arrthorizer::Permission.grant(other_privilege, to: generic_role)
          add_user_to_generic_role(current_user, generic_role)
        end

        it "fails" do
          get :some_action

          response.should be_forbidden
        end
      end
    end

    describe "context roles" do
      let!(:context_role) do
        configure_context_role do |user, context|
          # This can be any type of check, e.g.:
          #   blog = Blog.find(context[:id])
          #   blog.author == user

          # For the purpose of this test, just do a simple check:
          # is the param :some_param equal to true.
          context.some_param == true
        end
      end

      context "when the role is linked to the privilege" do
        before do
          Arrthorizer::Permission.grant(privilege, to: context_role)
        end

        context "when I supply the correct 'some_param' param" do
          let(:allow_request) { true }

          it "succeeds" do
            get :some_action, some_param: allow_request

            response.should be_success
          end
        end

        context "when I do not supply the correct 'some_param' param" do
          let(:allow_request) { "something else" }

          it "succeeds" do
            get :some_action, some_param: allow_request

            response.should be_forbidden
          end
        end
      end

      context "when the role is linked to a different privilege" do
        before do
          other_privilege = other_action.privilege
          Arrthorizer::Permission.grant(other_privilege, to: context_role)
        end

        context "when I supply the correct 'some_param' param" do
          let(:allow_request) { true }

          it "still fails" do
            get :some_action, some_param: allow_request

            response.should be_forbidden
          end
        end
      end
    end
  end

  private
  def create_generic_role
    Arrthorizer::GenericRole.new("generic role")
  end

  def configure_context_role(&block)
    UnnamespacedContextRole.instance.tap do |role|
      role.stub(:applies_to_user?, &block)
    end
  end

  def add_user_to_generic_role( user, generic_role )
    # stub
  end
end
