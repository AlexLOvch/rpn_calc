# frozen_string_literal: true

require_relative './binary_operator'

module RpnCalc
  module Calculators
    module Operators
      class BinaryOperator < OperatorBase
        def arity
          2
        end

        def evaluate()
          operands[0].send(sign,operands[1])
        end
      end
    end
  end
end
