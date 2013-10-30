# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'serial_attr/version'

Gem::Specification.new do |spec|
  spec.name          = "serial_attr"
  spec.version       = SerialAttr::VERSION
  spec.authors       = ["Jason Haruska"]
  spec.email         = ["jason@haruska.com"]
  spec.description   = %q{Finer control over which attributes of a model to serialize}
  spec.summary       = %q{Model serialization}
  spec.homepage      = "https://github.com/haruska/serial_attr"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "activesupport", ">= 3.0.2", "< 4.1"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "test-unit"
  spec.add_development_dependency "shoulda-context"
  spec.add_development_dependency "factory_girl"
  spec.add_development_dependency "active_attr"
  spec.add_development_dependency "faker"
end
