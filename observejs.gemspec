# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'observejs/version'

Gem::Specification.new do |spec|
  spec.name          = "observejs"
  spec.version       = ObserveJS::VERSION
  spec.authors       = ["Pier-Olivier Thibault"]
  spec.email         = ["pothibo@gmail.com"]
  spec.summary       = %q{Event based JavaScript framework tailored for Ruby on rails.}
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rails", "~> 4.1"
  spec.add_development_dependency "sqlite3"
end
