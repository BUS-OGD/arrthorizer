module Arrthorizer
  class ArrthorizerException < StandardError
    attr_reader :inner

    def initialize(message = "Exception occurred", inner = $!)
      super(message)

      @inner = inner
    end
  end
end
