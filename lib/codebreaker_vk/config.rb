# frozen_string_literal: true

module CodebreakerVk
  CODE_LENGTH = 4

  EXACT_MATCH_SIGN = '+'
  NUMBER_MATCH_SIGN = '-'

  MIN_CODE_NUMBER = 1
  MAX_CODE_NUMBER = 6

  DIFFICULTIES = {
      easy: { tries: 15, hints: 2 },
      medium: { tries: 10, hints: 1 },
      hell: { tries: 5, hints: 1 }
  }.freeze
end
