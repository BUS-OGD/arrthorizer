# This is the abstract superclass for all roles in the hierarchy.
module Arrthorizer
  class Role
    # Template method: This method is implemented in the
    # ContextRole subclasses and GenericRole.
    def applies_to_user?(user, context = {})
      raise NotImplementedError
    end

    def self.get(name_or_role)
      repository.get(name_or_role)
    end

    def self.register(role)
      repository.add(role)
    end

    def self.repository
      @repository ||= Repository.new
    end
  end
end

