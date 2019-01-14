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
    class RpnCalculator
      attr_accessor :options, :stack, :parser, :evaluator, :errors

      extend Forwardable
      def_delegator :@parser, :parse, :parse_line
      def_delegator :@parser, :errors, :parser_errors
      def_delegator :@evaluator, :evaluate, :calculate
      def_delegator :@evaluator, :operators_signs, :allowed_operators

      def initialize(options = {})
        @options = options
        @stack = []
        @errors = []
        @evaluator =  Operators::OperatorsEvaluator

        @parser = Parsers::PlainTextParser.new(
          delimiter: options[:delimiter],
          validator: Validators::TokenValidator.new(allowed_tokens: allowed_operators),
          converter: Converters::TokenConverter.new(excluded_tokens: allowed_operators)
        )
      end

      def process(line)
        @errors = []
        tokens = parse_line(line)
        @errors += parser_errors

        return @stack if tokens.empty?

        while tokens.any?
          token = tokens.shift
          @stack.push(token)
          begin
            @stack = calculate(@stack) if allowed_operators.include?(token)
          rescue StandardError => error
require 'byebug'
byebug
            @errors << error.message
          end
        end
        @stack
      end
    end
  end
end
