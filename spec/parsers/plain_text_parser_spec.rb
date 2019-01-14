# frozen_string_literal: true

require 'spec_helper'

module RpnCalc
  RSpec.describe Parsers::PlainTextParser do
    describe '#parse' do
      context 'when options is empty' do
        subject(:parser) { described_class.new }

        it 'should parse source with space delimeter' do
          expect(parser.parse('1 2 +')).to eq ['1', '2', '+']
        end

        it 'should parse source properly in case of extra spaces present' do
          expect(parser.parse(' 1   2   + ')).to eq ['1', '2', '+']
        end
      end

      context 'when delimeter option is present' do
        subject(:parser) { described_class.new(delimiter: ',') }

        it 'should parse source with delimeter' do
          expect(parser.parse('1,2, +')).to eq ['1', '2', '+']
        end
      end

      context 'when validator option is present' do
        subject(:parser) { described_class.new(validator: Validators::TokenValidator.new(allowed_tokens: ['+'])) }

        it 'should parse source excluding wrong tokens' do
          expect(parser.parse('a 1 2 b + ++')).to eq ['1', '2', '+']
        end
      end

      context 'when validator and convertor options are present' do
        subject(:parser) do
          described_class.new(
            validator: Validators::TokenValidator.new(allowed_tokens: ['+']),
            converter: Converters::TokenConverter.new(excluded_tokens: ['+'])
          )
        end

        it 'should convert tokens' do
          expect(parser.parse('1 2.0 +')).to eq [1, 2.0, '+']
        end

        it 'should exclude wrong tokens and convert right ones' do
          expect(parser.parse('a 1 0.2 b + ++')).to eq [1, 0.2, '+']
        end
      end

      context 'when all options are present' do
        subject(:parser) do
          described_class.new(
            delimiter: ',',
            validator: Validators::TokenValidator.new(allowed_tokens: ['+']),
            converter: Converters::TokenConverter.new(excluded_tokens: ['+'])
          )
        end

        it 'should parse source properly' do
          expect(parser.parse('a, 1, 0.2, b, +, ++')).to eq [1, 0.2, '+']
        end

        it 'should have errors list with properly formulated error messages ' do
          parser.parse('a, 1, 0.2, b, +, ++')
          expect(parser.errors).to eq [
            "Operand or operator 'a' is invalid! Ignored.",
            "Operand or operator 'b' is invalid! Ignored.",
            "Operand or operator '++' is invalid! Ignored."
          ]
        end

        it 'should not save previoue errorshave errors list' do
          parser.parse('a, 1, 0.2, b, +, ++')
          parser.parse('1, 0.2, +')
          expect(parser.errors).to eq []
        end
      end
    end
  end
end
