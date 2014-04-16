module Arrthorizer::RSpec::SharedExamples
  shared_examples "not persisting state in the role object" do |options = {}|
    specify "no state is maintained in the role object" do
      the_role = options[:role] || role
      the_context = options[:current_context] || current_context

      the_role.applies_to_user?(user, Arrthorizer::Context(the_context))

      expect(the_role.instance.instance_variables).to be_empty
    end
  end
end
