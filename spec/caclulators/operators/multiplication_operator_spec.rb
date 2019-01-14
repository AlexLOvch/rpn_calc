# frozen_string_literal: true

require 'spec_helper'

module RpnCalc
  RSpec.describe Calculators::Operators::MultiplicationOperator do
    describe '#initialize' do
      context 'when input is valid' do
        it 'does not raise while initializing when operands present are and valid' do
          expect { described_class.new([1, 2]) }.not_to raise_error
        end

        it 'raises MissedOperands while initializing if operands are missed' do
          expect { described_class.new([1]) }.to raise_error(Calculators::Operators::MissedOperands)
        end
      end

      context 'when input is invalid' do
        it 'raises MissedOperands while initializing operands are present and invalid' do
          expect { described_class.new([1]) }.to raise_error(Calculators::Operators::MissedOperands)
        end
      end
    end

    describe '#evaluate' do
      context 'when input is valid' do
        it 'does not raise while evaluating if argumants a present' do
          expect { described_class.new([1, 2]) }.not_to raise_error
        end

        it 'returns multiply of arguments' do
          expect(described_class.new([2, 3]).evaluate).to eq 6
        end

        it 'returns multiply of fractional arguments' do
          expect(described_class.new([10, 0.5]).evaluate).to eq 5
        end
      end

      context 'when input is invalid' do
        it 'raises MissedOperands while initializing operands are missed' do
          expect { described_class.new([1]).evaluate }.to raise_error(Calculators::Operators::MissedOperands)
        end
      end
    end
  end
end
