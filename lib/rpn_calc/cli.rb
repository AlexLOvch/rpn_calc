# frozen_string_literal: true

require 'thor'

module RpnCalc
  # Handle the application command line parsing
  # and the dispatch to various command objects
  #
  # @api public
  class CLI < Thor
    # Error raised by this runner
    Error = Class.new(StandardError)

    desc 'version', 'rpn_calc version'
    def version
      require_relative 'version'
      puts "v#{RpnCalc::VERSION}"
    end
    map %w[--version -v] => :version

    desc 'cli', 'Command line interactive version of reverse polish notation colculator'
    method_option :help, aliases: '-h', type: :boolean,
                         desc: 'You can calculate result of full command like \'> 3 2 1 + *\' or enter operands '\
                               'and operators one by one'
    def cli(*)
      if options[:help]
        invoke :help, ['calc']
      else
        require_relative 'commands/cli'
        RpnCalc::Commands::Cli.new(options).execute
      end
    end

  end
end
