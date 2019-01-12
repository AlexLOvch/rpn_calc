# frozen_string_literal: true

module RpnCalc
  module Parsers
    # Allows to extract tokens from the input string
    class PlainTextParser
      attr_accessor :options

      def initialize(options)
        @options = options
      end

      def parse(input_string)
        input_string.chomp.split(options[:delimiter] || ' ')
      end
    end
  end
end
