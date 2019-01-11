# frozen_string_literal: true

Dir.glob("*_operator.rb").each do |file|
    require_relative file
end

module RpnCalc
  module Calculators
    module Operators
      class OperatorsEvaluator
        NonOperand = Class.new(ArgumentError)

        OPERATORS_HASH = {
          '+': AdditionOperator
        }

        class << self
          def operator_valid?(operator)
            OPERATORS_HASH.keys.include?(operator.to_sym)
          end

          def evaluate(stack)
            if operator_valid?(stack[0])
              operator = operator_instance(stack.pop)
              operands = stack.pop(operator.arity).reverse
              stack.push(operator.evaluate(operands))
            else
              raise NonOperand
            end

            stack
          end

          private

          def operator_instance(operator_sign)
            OPERATORS_HASH[operator_sign].new
          end
        end
      end
    end
  end
end
