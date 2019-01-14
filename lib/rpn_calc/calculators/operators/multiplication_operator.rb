# frozen_string_literal: true

require_relative './binary_operator_base'

module RpnCalc
  module Calculators
    module Operators
      # allows to multiply two operands from an operands array
      class MultiplicationOperator < BinaryOperatorBase
        def sign
          :*
        end
      end
    end
  end
end
