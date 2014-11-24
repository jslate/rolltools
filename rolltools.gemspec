# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rolltools/version'

Gem::Specification.new do |spec|
  spec.name          = "rolltools"
  spec.version       = Rolltools::VERSION
  spec.authors       = ["Jonathan Slate"]
  spec.email         = ["jslate@patientslikeme.com"]
  spec.summary       = %q{Tools for working with the Rollbar API.}
  spec.homepage      = "https://github.com/jslate/rolltools"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "thor"
  spec.add_dependency "faraday"
  spec.add_dependency "json"
  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
