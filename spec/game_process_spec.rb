# frozen_string_literal: true

require 'spec_helper'

module CodebreakerVk
  RSpec.describe GameProcess do
    subject(:game) { Game.new }

    describe '#check_guess' do
      let(:test_data) do
        [
            ['6543', '5643', '++--'],
            ['6543', '6411', '+-'],
            ['6543', '6544', '+++'],
            ['6543', '3456', '----'],
            ['6543', '6666', '+'],
            ['6543', '2666', '-'],
            ['6543', '2222', ''],
            ['6666', '1661', '++'],
            ['1234', '3124', '+---'],
            ['1234', '1524', '++-'],
            ['1234', '1234', '++++']
        ]
      end

      let(:wrong_inputs) do
        ['12345', '', 'aerwfds', 'f432tsda', '!@!$#!$', '7777', nil]
      end

      it 'returns correct results' do
        test_data.each do |test_case|
          game.instance_variable_set(:@secret, test_case[0].to_i.digits.reverse)

          expect(game.check_guess(test_case[1])).to eql(test_case[2])
        end
      end

      it 'decreases tries by 1' do
        expect do
          game.check_guess('1234')
        end.to change { game.instance_variable_get(:@tries_count) }.by(-1)
      end

      it 'adds error on wrong guess format' do
        wrong_inputs.size.times do |i|
          game.check_guess(wrong_inputs[i])

          expect(game.errors).to include(FormatError)
        end
      end

      it 'increases tries_used by one' do
        expect do
          game.check_guess('1234')
        end.to change { game.data[:tries_used] }.by(1)
      end
    end
  end
end
