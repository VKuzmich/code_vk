# frozen_string_literal: true

module CodebreakerVk
  module Validate
    def check_cover?(cheackable, valid_numbers)
      valid_numbers.cover?(cheackable.size)
    end

    def check_include?(cheackable, valid_collection)
      valid_collection.include?(cheackable)
    end

    def check_size?(cheackable, valid_size)
      cheackable.size == valid_size
    end

    def check_numbers?(cheackable, valid_numbers)
      cheackable.each_char.all? { |guess_char| valid_numbers.include?(guess_char) }
    end
  end
end
