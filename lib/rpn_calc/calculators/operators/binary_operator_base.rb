# frozen_string_literal: true

require_relative './operator_base'

module RpnCalc
  module Calculators
    module Operators
      # base class for all binary operators - allows call operator for first operand with secong as arg
      class BinaryOperatorBase < OperatorBase
        def arity
          2
        end

        def evaluate
          validate_operands

          operands[0].send(sign, operands[1])
        end
      end
    end
  end
end
