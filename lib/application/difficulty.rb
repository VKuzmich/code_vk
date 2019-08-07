# frozen_string_literal: true

module CodebreakerVk
  class Difficulty
    attr_reader :level

    DIFFICULTIES = {
      simple: {
        hints: 2,
        attempts: 15,
        level: 'simple'
      },

      middle: {
        hints: 1,
        attempts: 10,
        level: 'middle'
      },

      hard: {
        hints: 1,
        attempts: 5,
        level: 'hard'
      }
    }.freeze

    def initialize(input)
      @level = DIFFICULTIES[input]
    end

    def self.find(input)
      input_as_key = input.to_sym
      return unless DIFFICULTIES.key?(input_as_key)

      new(input_as_key)
    end
  end
end
