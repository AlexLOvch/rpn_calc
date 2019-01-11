# frozen_string_literal: true

require_relative './command_base'

module RpnCalc
  module Commands
    class Cli < RpnCalc::CommandBase
      attr_accessor :options

      def initialize(options)
        @options = options
      end

      def execute(input: $stdin, output: $stdout)
        loop do
          output.print('> ')
          tokens = input.gets.chomp.split
          output.puts tokens
          break if tokens.last == 'q'
        end
      end
    end
  end
end
