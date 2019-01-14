# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rpn_calc/version'

Gem::Specification.new do |spec|
  spec.name          = 'rpn_calc'
  spec.license       = 'MIT'
  spec.version       = RpnCalc::VERSION
  spec.authors       = ['alex-o-clmtx']
  spec.email         = ['a.ovchinnikov@celmatix.com']

  spec.summary       = 'Implement a command-line reverse polish notation (RPN) calculator'
  spec.description   = 'The calculator uses standard input and standard output. It implements the four standard
                          arithmetic operators. The calculator handles errors and recover gracefully.
                          The calculator exits when it receives a q command or an end of input indicator (EOF / Ctrl+D)'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['source_code_uri'] = 'https://github.com/AlexLOvch/rpn_calc'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'thor', '~> 0.20.0'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.62.0'
  spec.add_development_dependency 'byebug', '~> 10.0'
  spec.add_development_dependency 'simplecov', '~> 0.16'
end
