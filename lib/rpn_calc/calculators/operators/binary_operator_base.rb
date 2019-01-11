# frozen_string_literal: true

require_relative './operator_base'

module RpnCalc
  module Calculators
    module Operators
      class BinaryOperatorBase < OperatorBase
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
