# frozen_string_literal: true

module RpnCalc
  module Calculators
    module Operators
      MissedOperands = Class.new(ArgumentError)
      # Base class for all operators
      class OperatorBase
        attr_accessor :operands

        def initialize(operands = nil)
          @operands = operands
          validate_operands if operands
        end

        def sign
          raise NotImplementedError, "#{self.class}##{__method__} must be implemented"
        end

        def arity
          raise NotImplementedError, "#{self.class}##{__method__} must be implemented"
        end

        def evaluate(_operands)
          raise NotImplementedError, "#{self.class}##{__method__} must be implemented"
        end

        def validate_operands
          message = "wrong number of arguments (given #{operands.size}, expected #{arity})"
          raise MissedOperands, message if operands.size < arity
        end
      end
    end
  end
end
