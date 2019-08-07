# frozen_string_literal: true

require 'spec_helper'

module CodebreakerVk
  RSpec.describe CheckErrors do
    subject(:check_errors) { described_class.new(Console::COMMANDS[:start]) }

    let(:valid_inputs) { [Console::COMMANDS[:start], Console::COMMANDS[:stats], Console::COMMANDS[:rules]] }
    let(:invalid_input) { Console::COMMANDS[:start].succ }

    describe '.new' do
      it { expect(check_errors.input).to eq(Console::COMMANDS[:start]) }
    end

    describe 'valid' do
      before { check_errors.validate }

      context 'when check_valid_inputs_include_in_COMMANDS' do
        it do
          valid_inputs.each do |valid_input|
            check_errors.instance_variable_set(:@input, valid_input)
            expect(check_errors.errors.empty?).to eq(true)
          end
        end
      end

      context 'when #valid? true' do
        it { expect(check_errors.valid?).to eq(true) }
      end
    end

    describe 'invalid' do
      before do
        check_errors.instance_variable_set(:@input, invalid_input)
        check_errors.validate
      end

      context 'when #validate false' do
        it { expect(check_errors.errors).to eq([I18n.t('invalid.include_error')]) }
      end

      context 'when #valid? false' do
        it { expect(check_errors.valid?).to eq(false) }
      end
    end
  end
end
