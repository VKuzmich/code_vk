# frozen_string_literal: true

require 'spec_helper'

module CodebreakerVk
  RSpec.describe GameMessages do
    let(:difficulty_keys) { Difficulty::DIFFICULTIES.keys.join(', ') }
    let(:arg) { 1 }
    let(:error) { 'Invalid error' }
    let(:game_double) { instance_double('Game', difficulty: difficalty_double, user: user_double) }
    let(:valid_name) { 'a' * User::VALID_NAME_SIZE.min }
    let(:difficalty_double) { instance_double('Difficalty', level: Difficulty::DIFFICULTIES[:simple]) }
    let(:user_double) { instance_double('User', name: valid_name) }

    describe '.console_msg' do
      it { expect { described_class.greeting_msg }.to output(/Hello, lets play the 'Codebreaker' game/).to_stdout }
      it { expect { described_class.what_next_text }.to output(/Choose the command/).to_stdout }
      it { expect { described_class.what_name_msg }.to output(/What is your name/).to_stdout }
      it { expect { described_class.select_difficulty_msg }.to output(/Select difficulty: #{difficulty_keys}/).to_stdout }
      it { expect { described_class.make_guess_msg }.to output(/Make your guess/).to_stdout }
      it { expect { described_class.showed_hint_msg(arg) }.to output(/Code contains this number:/).to_stdout }
      it { expect { described_class.zero_hints_msg }.to output(/You don't have any hints/).to_stdout }
      it { expect { described_class.round_info_text(arg, arg, arg) }.to output(/Your result is 1/).to_stdout }
      it { expect { described_class.win_msg }.to output(/You win/).to_stdout }
      it { expect { described_class.lose_msg }.to output(/Game over/).to_stdout }
      it { expect { described_class.empty_db_msg }.to output(/You are the first one/).to_stdout }
      it { expect { described_class.show_rules }.to output(/Codebreaker is a logic game in which/).to_stdout }
    end

    describe '.error_msg' do
      it { expect { described_class.error_msg(error) }.to output(/Unexpected input, it was '#{error}'/).to_stdout }
    end

    describe '.goodbye_msg' do
      it { expect { described_class.goodbye }.to output(/Goodbye/).to_stdout }
    end

    describe '#sort_db' do
      it do
        results = Array.new(5) do |index|
          { name: "Player#{index + 2}", all_attempts: 15,
            all_hints: 2, level: 'simple', left_attempts: index, left_hints: 10 - index }
        end

        expect(described_class.send(:sort_db, results).first[:name]).to eq(results.last[:name])
      end
    end
  end
end
