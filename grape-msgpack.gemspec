# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'grape/msgpack/version'

Gem::Specification.new do |spec|
  spec.name          = "grape-msgpack"
  spec.version       = Grape::Msgpack::VERSION
  spec.authors       = ["Sho Kusano"]
  spec.email         = ["rosylilly@aduca.org"]
  spec.summary       = %q{msgpack formatter for grape}
  spec.description   = %q{msgpack formatter for grape}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 2.14.1'
  spec.add_development_dependency 'rack-test', '~> 0.6.2'
  spec.add_development_dependency 'grape-entity', '~> 0.3.0'

  spec.add_dependency 'grape', '~> 0.6.0'
  spec.add_dependency 'msgpack', '~> 0.5.6'
end
