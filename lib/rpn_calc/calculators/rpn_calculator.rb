# frozen_string_literal: true

require_relative './operators/operators_evaluator'

module RpnCalc
  module Calculators
    # Allows to process stack with  prepared operand and operators
    #
    # @api public
    class RPNCalculator
      attr_accessor :options, :stack

      def initialize(options)
        @options = options
        @stack = []
        @errors = []
      end

      def process(tokens = [])
        stack << tokens if tokens.any?
        return stack if stack.empty?

        loop do
          RpnCalc::Calculators::Operators::OperatorsEvaluator.evaluate(stack)
        rescue NonOperand
          break
        rescue StandardError => error
          errors << error.inspect
        end
        stack
      end
    end
  end
end