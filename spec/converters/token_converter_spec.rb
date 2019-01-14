# frozen_string_literal: true

require 'spec_helper'

module RpnCalc
  RSpec.describe Converters::TokenConverter do
    describe '#convert' do
      context 'when exclude tokens list is not present' do
        subject(:converter) { described_class.new }

        it 'should convert in case integer numbers string' do
          expect(converter.convert('123')).to eq 123
        end

        it 'should convert in case fractional numbers string' do
          expect(converter.convert('1.23')).to eq 1.23
        end

        it 'should raise in case of wrong token' do
          expect { converter.convert('abc') }.to raise_error(Converters::WrongToken)
        end
      end

      context 'when exclude tokens list is present' do
        subject(:converter) { described_class.new(excluded_tokens: ['+', '-']) }

        it 'should not convert in case string in excluded tokens list' do
          expect(converter.convert('+')).to eq '+'
        end
      end
    end
  end
end
