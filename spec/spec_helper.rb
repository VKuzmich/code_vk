# frozen_string_literal: true

require 'simplecov'
SimpleCov.start do
  minimum_coverage 95
end

require_relative '../lib/codebreaker_vk.rb'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
    expectations.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.disable_monkey_patching!
end