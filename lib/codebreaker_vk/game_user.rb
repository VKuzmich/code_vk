# frozen_string_literal: true

module CodebreakerVk
  class GameUser < ValidatingData
    attr_reader :name, :errors

    VALID_NAME_SIZE = (3..20).freeze

    def initialize(name)
      super()
      @name = name
    end

    def validate
      @errors << I18n.t('invalid.cover_error') unless check_cover?(@name, VALID_NAME_SIZE)
    end
  end
end
