require "arrthorizer/version"

module Arrthorizer
  autoload :ArrthorizerException,     "arrthorizer/arrthorizer_exception"

  autoload :Registry,                 "arrthorizer/registry"

  autoload :Role,                     "arrthorizer/role"
  autoload :ContextRole,              "arrthorizer/context_role"
  autoload :Group,                    "arrthorizer/group"

  autoload :Permission,               "arrthorizer/permission"
  autoload :Privilege,                "arrthorizer/privilege"

  autoload :ContextBuilder,           "arrthorizer/context_builder"

  autoload :Rails,                    "arrthorizer/rails"

  require 'arrthorizer/context'
  require 'arrthorizer/roles'

  if defined?(::Rails)
    Arrthorizer::Rails.initialize!
  end

  def self.configure(&block)
    self.instance_eval(&block)
  end

  ##
  # Inject a dependency for Arrthorizer's Groups feature.
  # The provided object needs to be able to respond_to :is_member_of?
  # The is_member_of? function is expected to return a boolean-like
  # object which represents whether or not the user is a member of the
  # provided Group
  def self.check_group_membership_using(object)
    if object.respond_to?(:is_member_of?)
      @membership_service = object
    else
      raise "Arrthorizer cannot check role membership using #{object.inspect}"
    end
  end

  def self.membership_service
    @membership_service
  end

  if defined?(RSpec)
    require 'arrthorizer/rspec'
  end
end
