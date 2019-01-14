# CLI RPN Calculator

Implements a command-line reverse polish notation (RPN) calculator. In the current version only 4 operators allowed:  addition (+),  multiplication (*), subtraction (-) and division (/). Full requirements can be found [here](https://gist.github.com/joedean/078a62b9ec03b38dfc519b3a5f168b07).

## Installation

Clone this github repository:

```console
$ git clone git@github.com:AlexLOvch/rpn_calc.git
```

And then execute:
```console
$ bundle
```

TODO: Upload gem and add gem install instruction here

## Usage

    $ cd rpn_calc/exe/
    $ ./rpc_calc

You'll see commands help:
```console
 Commands:
   rpn_calc cli             # Command line interactive version of reverse polish notation colculator. You can calculate result of full command like '> 3 2 1 + *' or e...
   rpn_calc help [COMMAND]  # Describe available commands or one specific command
   rpn_calc version         # rpn_calc version
```

To see command options use -h option: 
```console
 $ ./rpn_calc cli -h
Usage:
  rpn_calc cli

Options:
  -h, [--help], [--no-help]    # Help for this command
  -d, [--delimiter=DELIMITER]  #  Space will be used by default.
  -i, [--input=INPUT]          # Input source for calculator
                               # Default: console
                               # Possible values: console
  -o, [--output=OUTPUT]        # Output source for calculator
                               # Default: console
                               # Possible values: console
```
To run interactive RPN calculator type:
```console
 $ ./rpn_calc cli
```
Now you are able to enter reverse polish expression like:
```console
 > 1 2 3 + -
-4.0
> q
Bye!
```
Or enter operands and operators one by one
```console
 > 1
1.0
> 2.5
2.5
> +
3.5
> -0.5
-0.5
> -
4.0
> 2
2.0
> *
8.0
> q
Bye!
```
To  quit from RPN calculator enter `q` or press `Ctrl+D`

## Technical notes / architectural choices

* In order to speed up kick off of console application [tty](https://github.com/piotrmurach/tty) had been used.
* The architectural solution uses [SOLID](https://en.wikipedia.org/wiki/SOLID) principles. 
* Reverse polish notation calculation task had been split for two steps: 
    1. Parse input string. The main class for this step is `Parsers::PlainTextParser`. `PlainTextParser` can be configured by initializing options including `:delimiter`, `:validator` and `:converter`. First of all `PlainTextParser` splits input line to tokens list by `:delimiter`. Then using `:validator` and `:converter` (separate classes instances(`Validators::TokenValidator` and `Converters::TokenConverter` accordingly) it process tokens. `TokenValidator` allows to exclude wrong tokens, and returns validation  errors. `TokenConverter` allows to convert string tokens into numeric ones. The output of parsing is tokens list(ruby array).
    2. Process stack. Adding tokens from input tokens list into stack(also ruby array) `RpnCalculator` uses `Operators::OperatorsEvaluator` class to calculate each operation. There are separate operator classes to evaluate arithmetic operations `+`, `-`, `*` and `/`(in the `Operators` module: `AdditionOperator`, `SubtractionOperator`, `MultiplicationOperator` and `DivisionOperator` accordingly).   
* All classes(except most top one `RpnCalculator`) based on [SRP](https://en.wikipedia.org/wiki/Single_responsibility_principle), so they are loosely coupled and highly reusable. That's maybe not so important for such small project as that one, but should be highly recommended for big ones. 
* To simplify using alternate interface(as per requirements) class `IOProviders::IOProviderConsole` had been extracted.
* Сode is well tested(coverage is 98.65%)
* Code is [Rubocop](https://github.com/rubocop-hq/rubocop) requirements compatible

## Trade-offs/possible improvments

### For user
* Add subcommands `clear_stack` and `show_stack`
* Add UI inhancements like colorized output with [pastel](https://github.com/piotrmurach/pastel)

### From technical side
* DRY specs for operators
* Automate getting operators list in the `Operators::OperatorsEvaluator` by `Operators::OperatorBase` descendants processing
* Upload gem to RubyGems.org and update Installation part of this doc accordingly
* Add integration test for CLI command

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. 

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/AlexLOvch/rpn_calc. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Code of Conduct

Everyone interacting in the RpnCalc project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/rpn_calc/blob/master/CODE_OF_CONDUCT.md).

## Copyright

Copyright (c) 2019 alex-o-clmtx. See [MIT License](LICENSE.txt) for further details.
