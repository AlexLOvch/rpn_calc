# frozen_string_literal: true

require_relative './command_base'
require_relative '../calculators/rpn_calculator.rb'
require_relative '../io_providers/io_provider_console.rb'

module RpnCalc
  module Commands
    # Defines command cli working as REPL
    #
    # @api public
    class Cli < RpnCalc::CommandBase
      attr_accessor :options, :rpn_calculator, :input_stream, :ouput_stream

      def initialize(options)
        @options = options
        @rpn_calculator = Calculators::RpnCalculator.new(options)
        @input_stream = IOProviders::IOProviderConsole.new if options[:input] == 'console'
        @output_stream = IOProviders::IOProviderConsole.new if options[:output] == 'console'
      end

      def execute()
        loop do
          input_line = @input_stream.read&.chomp
          if input_line == 'q' || input_line.nil?
            @output_stream.write("Bye!\n")
            break
          end

          rpn_calculator.process(input_line) unless input_line.to_s.empty?

          @output_stream.write(rpn_calculator.stack[-1].to_s + "\n") if rpn_calculator.stack.any?
          @output_stream.write("  Warnings/Errors: "+ rpn_calculator.errors.join(' ') + "\n") if rpn_calculator.errors.any?
        end
      end
    end
  end
end
