# frozen_string_literal: true

require 'spec_helper'

module CodebreakerVk
  RSpec.describe GameUser do
    subject(:user) { described_class.new(valid_name) }

    let(:valid_name) { 'a' * GameUser::VALID_NAME_SIZE.first }
    let(:empty_string) { '' }

    describe '.new' do
      it { expect(user.name).to eq(valid_name) }
      it { expect(user.instance_variable_get(:@errors)).to eq([]) }
    end

    describe 'valid' do
      before { user.validate }

      context 'when #validate true' do
        it { expect(user.errors.empty?).to eq(true) }
      end

      context 'when #valid? true' do
        it { expect(user.valid?).to eq(true) }
      end
    end

    describe 'invalid' do
      before do
        user.instance_variable_set(:@name, empty_string)
        user.validate
      end

      context 'when #validate false' do
        it { expect(user.errors).to eq([I18n.t('invalid.cover_error')]) }
      end

      context 'when #valid? false' do
        it { expect(user.valid?).to eq(false) }
      end
    end
  end
end
