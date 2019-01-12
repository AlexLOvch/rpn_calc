# frozen_string_literal: true

module RpnCalc
  module Validators
    # Allows to check token by availabililty list or is it numeric
    class TokensValidator
      attr_accessor :allowed_tokens, :errors

      def initialize(options = {})
        @allowed_tokens = options[:allowed_tokens]
      end

      def valid?(token)
        @errors = []
        return true if (allowed_tokens&.include?(token)) || valid_number?(token)

        @errors = ["Operand or operator '#{token}' is invalid!"]
        false
      end

      def valid_number?(token)
        Float(token)
      rescue StandardError
        false
      end
    end
  end
end
