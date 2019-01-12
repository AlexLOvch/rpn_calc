# frozen_string_literal: true

require_relative './binary_operator_base'

module RpnCalc
  module Calculators
    module Operators
      class AdditionOperator < BinaryOperatorBase
        def sign
          :+
        end
      end
    end
  end
end
