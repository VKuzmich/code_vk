# frozen_string_literal: true

require 'spec_helper'

module CodebreakerVk
  RSpec.describe Game do
    let(:game) { Game.new }

    it { is_expected.to respond_to(:tries_count) }
    it { is_expected.not_to respond_to(:tries_count=) }

    it { is_expected.to respond_to(:hints_count) }
    it { is_expected.not_to respond_to(:hints_count=) }

    describe '#difficulty' do
      it 'sets default difficulty' do
        expect(game.instance_variable_get(:@difficulty)).to be(:kid)
      end

      it 'sets custom difficulty' do
        test = Game.new(difficulty: :average)
        expect(test.instance_variable_get(:@difficulty)).to be(:average)
      end

      it 'return error on non-existent difficulty' do
        expect { Game.new(difficulty: :assas) }.to raise_error(DifficultyLevelError)
      end
    end

    describe '#initialize' do
      context 'when hints variable' do
        let(:hint_indexes) { game.instance_variable_get(:@hint_indexes) }

        it 'not empty' do
          expect(hint_indexes).not_to be_empty
        end

        it 'with numbers from 0 to 3' do
          expect(hint_indexes).to eql([0, 1, 2, 3])
        end
      end

      context 'when secret code' do
        let(:secret_code) { game.instance_variable_get(:@secret) }

        it 'not empty' do
          expect(secret_code).not_to be_empty
        end

        it 'with 4 numbers' do
          expect(secret_code.size).to be(4)
        end

        it 'with numbers from 1 to 6' do
          expect(secret_code.join).to match(/[1-6]+/)
        end

        it 'new each time game starts' do
          code1 = secret_code
          game2 = Game.new
          code2 = game2.instance_variable_get(:@code)

          expect(code1).not_to eql(code2)
        end
      end

      context 'when tries_count variable' do
        let(:tries_count) { game.instance_variable_get(:@tries_count) }

        it 'not nil' do
          expect(tries_count).not_to eql(nil)
        end

        it 'with the correct data' do
          expect(tries_count).to be(15)
        end
      end

      context 'when hints_count variable' do
        let(:hints_count) { game.instance_variable_get(:@hints_count) }

        it 'not nil' do
          expect(hints_count).not_to eql(nil)
        end

        it 'with the correct data' do
          expect(hints_count).to be(2)
        end
      end
    end

    describe '#generate_hint' do
      before do
        game.instance_variable_set(:@secret, [6, 5, 4, 3])
      end

      it 'generates correct hint' do
        game.instance_variable_set(:@hints_count, 99)

        4.times do
          hint = game.generate_hint

          expect(game.instance_variable_get(:@secret)).to include(hint)
        end
      end

      it 'generates new hint each time' do
        game.instance_variable_set(:@hints_count, 99)

        hint1 = game.generate_hint
        hint2 = game.generate_hint
        hint3 = game.generate_hint
        hint4 = game.generate_hint

        expect(hint1).not_to eql(hint2)
        expect(hint2).not_to eql(hint3)
        expect(hint3).not_to eql(hint4)
        expect(hint4).not_to eql(hint1)
      end

      it 'reduces hint_indexes by one' do
        expect do
          game.generate_hint
        end.to change { game.instance_variable_get(:@hint_indexes).size }.by(-1)
      end

      it 'decreases hints_count by one' do
        expect do
          game.generate_hint
        end.to change { game.instance_variable_get(:@hints_count) }.by(-1)
      end

      it 'increases hints_used by one' do
        expect do
          game.generate_hint
        end.to change { game.data[:hints_used] }.by(1)
      end

      it 'adds error if no hints left' do
        game.instance_variable_set(:@hints_count, 0)

        game.generate_hint

        expect(game.errors).to include(MaxHintError)
      end
    end

    describe '#win?' do
      before do
        game.instance_variable_set(:@secret, [6, 5, 4, 3])
      end

      it 'returns true if guessed' do
        game.check_guess('6543')

        expect(game.win?).to be(true)
      end

      it 'returns false if not guessed' do
        game.check_guess('1111')

        expect(game.win?).to be(false)
      end
    end

    describe '#lose?' do
      it 'returns true if no tries left' do
        game.instance_variable_set(:@tries_count, 0)

        expect(game.lose?).to be(true)
      end

      it 'returns false if one more tries left' do
        game.instance_variable_set(:@tries_count, 1)

        expect(game.lose?).to be(false)
      end
    end
  end
end