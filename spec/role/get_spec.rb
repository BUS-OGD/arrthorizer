require "spec_helper"

require_relative 'shared_examples/finding_the_right_role.rb'

describe Arrthorizer::Role do
  describe :get do
    describe "fetching ContextRoles" do
      let(:expected_role) { Namespaced::ContextRole.instance } # provided by the internal Rails app

      context "when a ContextRole class is provided" do
        it_behaves_like "finding the right Role" do
          let(:arg) { expected_role.class }
        end
      end

      context "when a String representing a ContextRole instance is provided" do
        it_behaves_like "finding the right Role" do
          let(:arg) { expected_role.to_key }
        end
      end

      context "when a ContextRole instance is provided" do
        it_behaves_like "finding the right Role" do
          let(:arg) { expected_role }
        end
      end
    end

    context "fetching Groups" do
      let(:expected_role) { SomeGroup } # provided by the internal Rails app

      context "when a Group is provided" do
        it_behaves_like "finding the right Role" do
          let(:arg) { expected_role }
        end
      end

      context "when a String representing a Group is provided" do
        it_behaves_like "finding the right Role" do
          let(:arg) { expected_role.to_key }
        end
      end
    end
  end
end
