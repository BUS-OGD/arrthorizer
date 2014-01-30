##
# This is the class of all Generic Roles. A Generic Role is a role that does
# not depend on context, but rather on membership - a user can be made a member
# of such a role. This might be related to that person's role in the
# organization, for example.
module Arrthorizer
  class GenericRole < Role
    attr_reader :name

    def initialize(name)
      @name = name

      Role.register(self)
    end

    def applies_to_user?(user, context)
      false
    end
  end
end

