# frozen_string_literal: true

require 'spec_helper'

module RpnCalc
  RSpec.describe Calculators::RpnCalculator do
    describe '#process' do
      context 'when options are empty' do
        subject(:calculator) { described_class.new }

        it 'should return stack with right calculated result' do
          expect(calculator.process('1 2 +')).to eq [3]
        end

        it 'should save result in inner stack and continue evaluation with it' do
          calculator.process('1 2 +')
          expect(calculator.process('3 +')).to eq [6]
        end

        it 'should evaluatу multioperator expressions' do
          expect(calculator.process('3 9 1 2 3 * + - /')).to eq [1.5]
        end

        it 'should evaluatу mixed multioperator expressions' do
          expect(calculator.process('3 9 2 3 * 1 + - /')).to eq [1.5]
        end

        it 'should set parser errors if any' do
          calculator.process('1 abc 2 + ')
          expect(calculator.errors).to eq ["Operand or operator 'abc' is invalid! Ignored."]
        end

        it 'should should return Infinity in case of zero divizion' do
          expect(calculator.process('1 0 /')).to eq [Float::INFINITY]
        end
      end
    end
  end
end
