# frozen_string_literal: true

require_relative 'difficulty'

module CodebreakerVk
  class GameProcess < ValidatingData
    attr_reader :input, :errors

    HINT = 'hint'

    def initialize(input)
      super()
      @input = input
    end

    def validate
      return if hint?

      @errors << I18n.t('invalid.include_error') unless check_numbers?(@input, valid_numbers)
      @errors << I18n.t('invalid.size_error') unless check_size?(@input, Game::CODE_SIZE)
    end

    def as_array_of_numbers
      @as_array_of_numbers ||= @input.chars.map(&:to_i)
    end

    def hint?
      @input == HINT
    end

    private

    def valid_numbers
      Game::INCLUDE_IN_GAME_NUMBERS.map(&:to_s)
    end
  end
end
