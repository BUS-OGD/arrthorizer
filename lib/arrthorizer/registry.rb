module Arrthorizer
  class Registry
    include Enumerable

    NotFound = Class.new(ArrthorizerException)

    def each(&block)
      storage.values.each(&block)
    end

    def initialize
      self.storage = Hash.new
    end

    def add(object)
      storage[object.to_key] = object
    end

    def fetch(key, &block)
      block ||= proc { raise NotFound, "Could not find value for #{key.inspect}" }

      formatted_key = key.respond_to?(:to_key) ? key.to_key : key

      storage.fetch(formatted_key, &block)
    end

    private
    attr_accessor :storage
  end
end
