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
      end

      context 'when delimeter options is present' do
        subject(:parser) { described_class.new(delimiter: ',') }

        it 'should parse source with delimeter' do
          expect(parser.parse('1,2,+')).to eq ['1', '2', '+']
        end
      end
    end
  end
end
