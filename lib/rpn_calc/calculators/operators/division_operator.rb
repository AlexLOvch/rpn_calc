# frozen_string_literal: true

require_relative './binary_operator_base'

module RpnCalc
  module Calculators
    module Operators
      # allows to substract second operand from first
      class DivisionOperator < BinaryOperatorBase
        def sign
          :/
        end
      end
    end
  end
end
