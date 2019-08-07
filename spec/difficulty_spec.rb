# frozen_string_literal: true

require 'spec_helper'

module CodebreakerVk
  RSpec.describe Difficulty do
    let(:valid_inputs) do
      [Difficulty::DIFFICULTIES[:simple][:level],
       Difficulty::DIFFICULTIES[:middle][:level],
       Difficulty::DIFFICULTIES[:hard][:level]]
    end

    let(:invalid_inputs) do
      [Difficulty::DIFFICULTIES[:simple][:level].succ,
       Difficulty::DIFFICULTIES[:middle][:level].succ,
       Difficulty::DIFFICULTIES[:hard][:level].succ]
    end

    describe '.find' do
      context 'when valid' do
        it do
          valid_inputs.each do |valid_input|
            expect(described_class.find(valid_input)).not_to eq(nil)
            expect(Difficulty::DIFFICULTIES.keys).to include(valid_input.to_sym)
          end
        end
      end

      context 'when invalid' do
        it do
          invalid_inputs.each do |invalid_input|
            expect(described_class.find(invalid_input)).to eq(nil)
            expect(Difficulty::DIFFICULTIES.keys).not_to include(invalid_input.to_sym)
          end
        end
      end
    end
  end
end
