# frozen_string_literal: true

module RpnCalc
  module IOProviders
    # Base class for IO operations
    class IOProviderBase
      attr_accessor :options

      def initialize(options = nil)
        @options = options
      end

      def read
        raise NotImplementedError, "#{self.class}##{__method__} must be implemented"
      end

      def write
        raise NotImplementedError, "#{self.class}##{__method__} must be implemented"
      end
    end
  end
end
