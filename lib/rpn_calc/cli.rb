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

    desc 'cli', 'Command line interactive version of reverse polish notation colculator. You can calculate result of '\
                ' full command like \'> 3 2 1 + *\' or enter operands and operators one by one'
    method_option :help, aliases: '-h', type: :boolean,
                         desc: 'Help for this command'
    method_option :delimiter, aliases: '-d', type: :string, default: ' ',
                         desc: 'Delimiter for operands and operators. Space will be used by default.'
    def cli(*)
      if options[:help]
        invoke :help, ['cli']
      else
        require_relative 'commands/cli'
        RpnCalc::Commands::Cli.new(options).execute
      end
    end

  end
end
