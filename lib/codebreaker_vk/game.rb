# frozen_string_literal: true

require_relative 'config'

module CodebreakerVk
  class Game
    attr_reader :tries_count, :hints_count, :errors

    def initialize(difficulty: :kid)
      validate_difficulty(difficulty)

      @difficulty   = difficulty

      @hint_indexes = (0...CODE_LENGTH).to_a

      @secret       = Array.new(CODE_LENGTH) { rand(MIN_CODE_NUMBER..MAX_CODE_NUMBER) }

      @tries_count  = DIFFICULTIES[@difficulty][:tries]
      @hints_count  = DIFFICULTIES[@difficulty][:hints]

      @errors       = []

      @matches      = ''
    end

    def check_guess(input)
      input = to_array(input)

      return add_error(GuessFormatError) unless valid? input

      @tries_count -= 1

      resolver = CodeResolver.new(@secret, input)

      @matches = resolver.matches
    end

    def generate_hint
      return add_error(NoHintsError) if @hints_count.zero?

      index = @hint_indexes.sample

      hint = @secret[index]

      @hint_indexes.delete index

      @hints_count -= 1

      hint
    end

    def win?
      @matches == Array.new(CODE_LENGTH, EXACT_MATCH_SIGN).join
    end

    def lose?
      @tries_count.zero?
    end

    def data
      {
          difficulty: DIFFICULTIES.keys.index(@difficulty),
          secret: @secret,
          tries_total: DIFFICULTIES[@difficulty][:tries],
          hints_total: DIFFICULTIES[@difficulty][:hints],
          tries_used: DIFFICULTIES[@difficulty][:tries] - @tries_count,
          hints_used: DIFFICULTIES[@difficulty][:hints] - @hints_count
      }
    end

    private

    def add_error(err)
      (@errors << err) && nil
    end

    def validate_difficulty(difficulty)
      raise DifficultyError unless DIFFICULTIES.include? difficulty.to_sym
    end

    def to_array(input)
      input.to_i.digits.reverse
    end

    def valid?(input)
      input.size == CODE_LENGTH && input.all? { |number| number.between? MIN_CODE_NUMBER, MAX_CODE_NUMBER }
    end
  end
end