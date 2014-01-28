module Arrthorizer
  class Repository
    include Enumerable

    NotFound = Class.new(ArrthorizerException)

    def each(&block)
      storage.values.each(&block)
    end

    def initialize
      self.storage = Hash.new
    end

    def add(privilege)
      storage[privilege.name] = privilege
    end

    def fetch(key, &block)
      block ||= proc { raise NotFound, "Could not find value for #{key.inspect}" }

      formatted_key = key.respond_to?(:name) ? key.name : key

      storage.fetch(formatted_key, &block)
    end

    private
    attr_accessor :storage
  end
end
