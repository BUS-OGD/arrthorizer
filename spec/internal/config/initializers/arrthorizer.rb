class EmptyMembershipService
  def is_member_of?(*args)
    raise NotImplementedError
  end
end

Arrthorizer.configure do
  check_group_membership_using EmptyMembershipService.new
end
