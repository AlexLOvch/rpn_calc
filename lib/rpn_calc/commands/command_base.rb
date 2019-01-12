# frozen_string_literal: true

require 'forwardable'

module RpnCalc
  # Defines base class for all console commands
  #
  # @api public
  class CommandBase
    extend Forwardable

    def_delegators :command, :run

    # Execute this command
    #
    # @api public
    def execute(*)
      raise(
        NotImplementedError,
        "#{self.class}##{__method__} must be implemented"
      )
    end
  end
end
