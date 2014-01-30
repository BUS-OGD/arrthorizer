require 'singleton'

##
# This is the superclass for all ContextRoles that the application may contain.
# A ContextRole is a role that a User may or may not have, depending on the
# current context. This can be things like 'the author of a certain post' or 'a
# member of the current group'
module Arrthorizer
  class ContextRole < Role
    include Singleton

    def to_key
      self.class.name.underscore
    end

    def self.applies_to_user?(*args)
      instance.applies_to_user?(*args)
    end

    def self.inherited(klass)
      super

      Role.register(klass.instance)
    end
  end
end

