# frozen_string_literal: true

require 'spec_helper'

module RpnCalc
  RSpec.describe Calculators::Operators::AdditionOperator do
    describe '#initialize' do
      context 'when input is valid' do
        it 'does not raise while initializing' do
          expect { described_class.new([1, 2]) }.not_to raise_error
        end
      end

      context 'when input is invalid' do
        it 'raises MissedOperands while initializing' do
          expect { described_class.new([1]) }.to raise_error(Calculators::Operators::MissedOperands)
        end
      end
    end

    describe '#evaluate' do
      context 'when input is valid' do
        it 'does not raise while initializing' do
          expect { described_class.new([1, 2]) }.not_to raise_error
        end

        it 'returns sum of arguments' do
          expect(described_class.new([1, 2]).evaluate).to eq 3
        end

        it 'returns sum of fractional arguments' do
          expect(described_class.new([3.0, 0.2]).evaluate).to eq 3.2
        end
      end
    end
  end
end
