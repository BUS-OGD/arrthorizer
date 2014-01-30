require "arrthorizer/version"

module Arrthorizer
  autoload :ArrthorizerException,     "arrthorizer/arrthorizer_exception"

  autoload :Registry,                 "arrthorizer/registry"

  autoload :Role,                     "arrthorizer/role"
  autoload :ContextRole,              "arrthorizer/context_role"
  autoload :GenericRole,              "arrthorizer/generic_role"

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
    self.tap(&block)
  end
end
