# frozen_string_literal: true

require_relative 'config'

module CodebreakerVk
  class GameProcess
    attr_reader :matches

    def initialize(secret_code, user_code)
      @secret_code    = secret_code.clone
      @user_code      = user_code

      @exact_matches  = 0
      @number_matches = 0

      @matches        = obtain_matches
    end

    private

    def obtain_matches
      calculate_matches unless @secret_code.empty?

      EXACT_MATCH_SIGN * @exact_matches << NUMBER_MATCH_SIGN * @number_matches
    end

    def calculate_matches
      @secret_code.zip(@user_code).each do |secret_code_number, user_code_number|
        next unless @secret_code.include? user_code_number

        next add_match(user_code_number, exact: true) if secret_code_number == user_code_number

        add_match(user_code_number)
      end
    end

    def add_match(matched_code_number, exact: false)
      exact ? @exact_matches += 1 : @number_matches += 1

      @secret_code.delete_at(@secret_code.index(matched_code_number))
    end
  end
end
