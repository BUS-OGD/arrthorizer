require 'arrthorizer/context_role'

class UnnamespacedContextRole < Arrthorizer::ContextRole
end

module Namespaced
  class ContextRole < Arrthorizer::ContextRole
  end
end
