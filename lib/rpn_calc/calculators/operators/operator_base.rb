# frozen_string_literal: true

module RpnCalc
  module Calculators
    module Operators
      class OperatorBase
        MissedOperands = Class.new(ArgumentError)

        attr accessor :operands

        def initialize(operands)
          @operands = operands
          validate_operands
        end

        def sign
          raise NotImplementedError, "#{self.class}##{__method__} must be implemented"
        end

        def arity
          raise NotImplementedError, "#{self.class}##{__method__} must be implemented"
        end

        def evaluate(operands)
          raise NotImplementedError, "#{self.class}##{__method__} must be implemented"
        end

        def validate_operands
          if operands.size < arity
            raise MissedOperands, "wrong number of arguments (given #{operands.size}, expected #{arity})"
          end
        end

      end
    end
  end
end
