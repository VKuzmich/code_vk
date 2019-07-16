# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "codebreaker_vk/version"

Gem::Specification.new do |spec|
  spec.name          = "codebreaker_vk"
  spec.version       = CodebreakerVk::VERSION
  spec.authors       = ["VKuzmich"]
  spec.email         = ["vjk1976@ukr.net"]

  spec.summary       = 'Codebreaker game'
  spec.description   = 'Game for everyone who likes to play.'
  spec.homepage      = 'https://github.com/VKuzmich/codebreaker_vk'
  spec.license       = 'MIT'


  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'fasterer', '~> 0.5.1'
  spec.add_development_dependency 'overcommit', '~> 0.48.0'
  spec.add_development_dependency 'pry', '~> 0.12.2'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.8'
  spec.add_development_dependency 'rubocop', '~> 0.70.0'
  spec.add_development_dependency 'rubocop-performance', '~> 1.3'
  spec.add_development_dependency 'rubocop-rspec', '~> 1.33'
  spec.add_development_dependency 'simplecov', '~> 0.16.1'
end
