# frozen_string_literal: true

module CodebreakerVk
  class ValidatingData
    include Validate

    def initialize
      @errors = []
    end

    def validate
      raise NotImplementedError
    end

    def valid?
      validate
      @errors.empty?
    end
  end
end
