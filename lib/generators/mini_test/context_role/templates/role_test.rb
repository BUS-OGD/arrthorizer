require 'test_helper'

class <%= class_name %>Test < ActiveSupport::TestCase
  def user
    @user ||= OpenStruct.new
  end

  def context_hash
    @context_hash ||= {}
  end

  def current_context
    Arrthorizer::Context.new(context_hash)
  end

  def role
    <%= class_name %>
  end

  def make_role_apply!
    # TODO: make the changes to the context_hash that make the role
    # apply to the user
  end

  def make_role_not_apply!
    # TODO: make the changes to the context_hash that make the role
    # *not* apply to the user
  end

  def test_returns_true_when_some_context
    make_role_apply!

    failure_message = "Expected #{role} to apply when context = #{current_context}"
    assert role.applies_to_user?(user, current_context), failure_message
  end

  def test_returns_false_when_some_other_context
    make_role_not_apply!

    failure_message = "Expected #{role} not_to apply when context = #{current_context}"
    refute role.applies_to_user?(user, current_context), failure_message
  end

  def test_when_true_no_state_is_maintained_in_instance
    make_role_apply!

    role.applies_to_user?(user, current_context)
    ivars = role.instance.instance_variables

    failure_message = "Expected apply_to_user? not to change state for #{role} (on instance), but it did"
    assert_empty ivars, failure_message
  end

  def test_when_false_no_state_is_maintained_in_instance
    make_role_not_apply!

    failure_message = "Expected apply_to_user? not to change state for #{role} (on instance), but it did"
    ivars = role.instance.instance_variables

    assert_empty ivars, failure_message
  end
end
