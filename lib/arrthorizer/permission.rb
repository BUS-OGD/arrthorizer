module Arrthorizer
  module Permission
    InvalidPermission = Class.new(ArrthorizerException)

    def self.grant(privilege_set, config = {})
      privilege_set = PrivilegeSet.get(privilege_set)
      role          = Role.get(config[:to])

      privilege_set.make_accessible_to(role)
    rescue Repository::NotFound => e
      raise InvalidPermission, e.message
    end
  end
end
