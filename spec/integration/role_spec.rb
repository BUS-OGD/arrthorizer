require 'spec_helper'

describe Arrthorizer::Role do
  context "when a new ContextRole class is created" do
    let(:context_role) { class TestRole < Arrthorizer::ContextRole; end; TestRole.instance }

    specify "that role is stored" do
      Arrthorizer::Role.get(context_role.name).should be context_role
    end

    after :each do
      if defined?(TestRole)
        Object.send(:remove_const, :TestRole)
      end
    end
  end
end
