class EmptyMembershipService
  def is_member_of?(*args)
    raise NotImplementedError
  end
end

Arrthorizer.configure do
  check_generic_roles_using EmptyMembershipService.new
end
