# frozen_string_literal: true

require_relative './io_provider_base.rb'

module RpnCalc
  module IOProviders
    class IOProviderConsole < IOProviderBase
      def read
        prompt()
        $stdin.gets
      end

      def write(string)
        $stdout.print(string)
      end

      protected

      def prompt
        write("> ")
      end
    end
  end
end
