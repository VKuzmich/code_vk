# frozen_string_literal: true

require_relative '../lib/application/version'

RSpec.describe CodebreakerVk do

  it 'has a version number' do
    expect(CodebreakerVk::VERSION).not_to be nil
  end

  it 'does something useful' do
    expect(true).to eq(true)
  end
end
