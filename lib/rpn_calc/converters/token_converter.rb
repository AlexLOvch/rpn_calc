# frozen_string_literal: true

module RpnCalc
  module Converters
    WrongToken = Class.new(ArgumentError)

    # Allows to convert token exludes availabililty list or is it numeric
    class TokenConverter
      attr_accessor :excluded_tokens

      def initialize(options = {})
        @excluded_tokens = options[:excluded_tokens]
      end

      def convert(token)
        return token if @excluded_tokens&.include?(token)

        to_number(token)
      end

      def to_number(token)
        Float(token)
      rescue ArgumentError
        raise WrongToken
      end
    end
  end
end
