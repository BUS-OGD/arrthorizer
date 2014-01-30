class UnnamespacedContextRole < Arrthorizer::ContextRole
  # this can be overridden in the specs
  def applies_to_user?(user, context)
    false
  end
end
