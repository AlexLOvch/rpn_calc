# frozen_string_literal: true

Dir.glob(File.dirname(__FILE__) + '/*_operator.rb').each do |file|
  require_relative file
end

module RpnCalc
  module Calculators
    module Operators
      # Allows to evaluate operator from stack
      class OperatorsEvaluator
        UnknownOperatorError = Class.new(ArgumentError)

        OPERATORS_HASH = {
          '+': Operators::AdditionOperator,
          '*': Operators::MultiplicationOperator,
          '-': Operators::SubtractionOperator,
          '/': Operators::DivisionOperator
        }.freeze

        class << self
          def evaluate(stack)
            raise UnknownOperatorError unless operator_valid?(stack[-1])

            operator = operator_instance(stack.pop)
            operator.operands = stack.pop(operator.arity)
            stack.push(operator.evaluate)
          end

          def operators_signs
            OPERATORS_HASH.keys.map(&:to_s)
          end

          def operator_valid?(operator)
            return false unless operator.respond_to?(:to_sym)

            OPERATORS_HASH.key?(operator.to_sym)
          end

          def operator_instance(operator_sign)
            OPERATORS_HASH[operator_sign.to_sym].new
          end
        end

        private_class_method :operator_valid?
        private_class_method :operator_instance
      end
    end
  end
end
