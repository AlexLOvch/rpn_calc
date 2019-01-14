# frozen_string_literal: true

require_relative './operators/operators_evaluator'
require 'rpn_calc/parsers/plain_text_parser'
require 'rpn_calc/validators/token_validator'
require 'rpn_calc/converters/token_converter'

require 'forwardable'

module RpnCalc
  module Calculators
    # Allows to process stack with  prepared operand and operators
    #
    # @api public
    class RPNCalculator
      attr_accessor :options, :stack, :parser

      extend Forwardable
      def_delegator :@parser, :parse, :parse_line

      def initialize(options)
        @options = options
        @stack = []
        @errors = []
        @parser = Parsers::PlainTextParser.new(@options)
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
