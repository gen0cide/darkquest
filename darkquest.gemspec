# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'darkquest/version'

Gem::Specification.new do |spec|
  spec.name          = "darkquest"
  spec.version       = Darkquest::VERSION
  spec.authors       = ["Alex Levinson"]
  spec.email         = ["gen0cide.threats@gmail.com"]
  spec.summary       = %q{This gem provides an API of standard functions commonly needed for DQS activity.}
  spec.description   = %q{Using the Darkquest server, this gem can interact with various components.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency     "sequel"
  spec.add_runtime_dependency     "mysql2"
  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
