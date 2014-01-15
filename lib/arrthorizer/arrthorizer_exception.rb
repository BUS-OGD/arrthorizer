module Arrthorizer
  class ArrthorizerException < StandardError
    attr_reader :original

    def initialize(message = "Exception occurred", original = $!)
      super(message)

      @original = original
    end
  end
end
