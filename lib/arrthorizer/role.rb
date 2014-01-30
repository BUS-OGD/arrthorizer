# This is the abstract superclass for all roles in the hierarchy.
module Arrthorizer
  class Role
    # Template method: This method is implemented in the
    # ContextRole subclasses and GenericRole.
    def applies_to_user?(user, context = {})
      raise NotImplementedError, "#{self.name} does not implement #applies_to_user?(user, context)"
    end

    def self.get(name_or_role)
      if name_or_role.respond_to?(:instance)
        get(name_or_role.instance)
      else
        registry.fetch(name_or_role)
      end
    end

    def self.register(role)
      registry.add(role)
    end

    def self.registry
      @registry ||= Registry.new
    end

    def to_key
      name
    end
  end
end

