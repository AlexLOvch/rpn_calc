# frozen_string_literal: true

require 'spec_helper'

module RpnCalc
  RSpec.describe Validators::TokenValidator do
    describe '#valid?' do
      context 'when allowed tokens list is not present' do
        subject(:validator) { described_class.new }

        it 'should return true in case integer number string' do
          expect(validator.valid?('123')).to be_truthy
        end

        it 'should return true in case fractional number string' do
          expect(validator.valid?('12.3')).to be_truthy
        end

        it 'should return false in case of string' do
          expect(validator.valid?('abc')).to be false
        end

        it 'should set error message in case of wrong token' do
          validator.valid?('abc')
          expect(validator.errors).to eq ['Operand or operator \'abc\' is invalid!']
        end

        it 'should should not save rror message from the previous run' do
          validator.valid?('abc')
          validator.valid?('1')
          expect(validator.errors).to eq []
        end
      end

      context 'when allowed tokens list is present' do
        subject(:validator) { described_class.new(allowed_tokens: ['+', '-']) }

        it 'should return true in case token is in the allowed list' do
          expect(validator.valid?('+')).to be_truthy
        end

        it 'should return false in case of string' do
          expect(validator.valid?('abc')).to be false
        end
      end
    end
  end
end
