module Arrthorizer
  class Everybody < Arrthorizer::ContextRole
    def applies_to_user?(*args)
      true
    end
  end

  class Nobody < Arrthorizer::ContextRole
    def applies_to_user?(*args)
      false
    end
  end

  class LoggedInUser < Arrthorizer::ContextRole
    def applies_to_user?(user, context)
      !user.nil?
    end
  end
end
