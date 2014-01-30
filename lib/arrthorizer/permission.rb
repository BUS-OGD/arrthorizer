module Arrthorizer
  module Permission
    InvalidPermission = Class.new(ArrthorizerException)

    def self.grant(privilege, config = {})
      privilege = Privilege.get(privilege)
      role          = Role.get(config[:to])

      privilege.make_accessible_to(role)
    rescue Registry::NotFound => e
      raise InvalidPermission, e.message
    end
  end
end
