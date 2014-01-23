module Arrthorizer
  class Repository
    NotFound = Class.new(ArrthorizerException)

    def initialize
      @storage = Hash.new do |hash, key| raise NotFound, "Could not find value for #{key.inspect}" end
    end

    def add(privilege)
      storage[privilege.name] = privilege
    end

    def get(key)
      if key.respond_to? :name
        storage[key.name]
      else
        storage[key]
      end
    end

    private
    attr_reader :storage
  end
end
