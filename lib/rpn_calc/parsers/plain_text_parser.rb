# frozen_string_literal: true

module RpnCalc
  module Parsers
    # Allows to extract tokens from the input string
    class PlainTextParser
      attr_accessor :delimiter, :validator, :converter, :errors

      def initialize(options = {})
        @delimiter = options[:delimiter]
        @validator = options[:validator]
        @converter = options[:converter]
      end

      def parse(input_string)
        @errors = []
        out = []

        tokens = input_string.chomp.split(delimiter || ' ')
        tokens.each do |token|
          out << convert(token) if valid?(token)
        end

        out
      end

      def valid?(token)
        return true unless validator

        @errors += validator.errors.map { |error| error + ' Ignored.' } unless validator.valid?(token)
      end

      def convert(token)
        return token unless converter

        converter.convert(token)
      end
    end
  end
end
