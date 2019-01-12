# frozen_string_literal: true

module RpnCalc
  module Converters
    # Allows to convert token exludes availabililty list or is it numeric
    class TokensConverter
      attr_accessor :excluded_tokens

      def initialize(options = {})
        @excluded_tokens = options[:excluded_tokens]
      end

      def convert(token)
        return token if excluded_tokens&.include?(token)

        to_number(token)
      end

      def to_number(token)
        Float(token)
      rescue StandardError
        0.0
      end
    end
  end
end
