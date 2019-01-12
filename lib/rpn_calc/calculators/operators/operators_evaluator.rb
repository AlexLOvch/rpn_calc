# frozen_string_literal: true

Dir.glob(File.dirname(__FILE__) + '/*_operator.rb').each do |file|
  require_relative file
end

module RpnCalc
  module Calculators
    module Operators
      # Allows to evaluate operator from stack
      class OperatorsEvaluator
        UnknownOperator = Class.new(ArgumentError)

        OPERATORS_HASH = {
          '+': Operators::AdditionOperator
        }.freeze

        class << self
          def evaluate(stack)
            raise UnknownOperator unless operator_valid?(stack[0])

            operator = operator_instance(stack.pop)
            operands = stack.pop(operator.arity).reverse
            stack.push(operator.evaluate(operands))
          end

          private

          def operator_valid?(operator)
            OPERATORS_HASH.key?(operator.to_sym)
          end

          def operator_instance(operator_sign)
            OPERATORS_HASH[operator_sign].new
          end
        end
      end
    end
  end
end
