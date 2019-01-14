# frozen_string_literal: true

require_relative './command_base'
require_relative '../calculators/rpn_calculator.rb'
module RpnCalc
  module Commands
    # Defines command cli working as REPL
    #
    # @api public
    class Cli < RpnCalc::CommandBase
      attr_accessor :options, :rpn_calculator

      def initialize(options)
        @options = options
        @rpn_calculator = Calculators::RpnCalculator.new(options)
      end

      def execute(input: $stdin, output: $stdout)
        loop do
          output.print('> ')
          input_line = input.gets&.chomp
          if input_line == 'q' || input_line.nil?
            output.puts('Bye!')
            break
          end
          rpn_calculator.process(input_line) unless input_line.to_s.empty?
          output.puts(rpn_calculator.stack[-1]) if rpn_calculator.stack.any?
          output.puts(" Errors: "+ rpn_calculator.errors.join(' ')) if rpn_calculator.errors.any?
        end
      end
    end
  end
end
