# frozen_string_literal: true

require 'spec_helper'

module CodebreakerVk
  RSpec.describe GameProcess do
    subject(:guess) { described_class.new(valid_guess) }

    let(:valid_numbers) { Game::INCLUDE_IN_GAME_NUMBERS.map(&:to_s) }
    let(:valid_guess) { valid_numbers.sample(4).join }
    let(:invalid_guess) { (Game::INCLUDE_IN_GAME_NUMBERS.max + 1).to_s * (Game::CODE_SIZE - 1) }

    describe '.new' do
      it { expect(guess.input).to eq(valid_guess) }
      it { expect(guess.instance_variable_get(:@errors)).to eq([]) }
    end

    describe '#as_array_of_numbers' do
      it { expect(guess.as_array_of_numbers).to eq(valid_guess.chars.map(&:to_i)) }
    end

    describe 'valid_check' do
      before { guess.validate }

      context 'when #validate true' do
        it { expect(guess.errors.empty?).to eq(true) }
      end

      context 'when #valid true?' do
        it { expect(guess.valid?).to eq(true) }
      end

      context 'when #hint true?' do
        it do
          guess.instance_variable_set(:@input, GameProcess::HINT)
          expect(guess.valid?).to eq(true)
        end
      end
    end

    describe 'invalid_check' do
      before do
        guess.instance_variable_set(:@input, invalid_guess)
        guess.validate
      end

      context 'when #validate false' do
        it { expect(guess.errors).to eq([I18n.t('invalid.include_error'), I18n.t('invalid.size_error')]) }
      end

      context 'when #valid false?' do
        it { expect(guess.valid?).to eq(false) }
      end

      context 'when #hint false?' do
        it do
          guess.instance_variable_set(:@input, GameProcess::HINT.succ)
          expect(guess.valid?).to eq(false)
        end
      end
    end
  end
end
