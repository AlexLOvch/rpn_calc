# frozen_string_literal: true

require_relative './operators/operators_evaluator'

module RpnCalc
  module Calculators
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
          begin
            stack = RpnCalc::Calculators::Operators::OperatorsEvaluator.evaluate(stack)
          rescue NonOperand
            break
          rescue StandardError => error
            errors << error.inspect
          end
        end
        stack
      end
    end
  end
end
