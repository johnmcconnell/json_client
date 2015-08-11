# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'json_client/version'

Gem::Specification.new do |spec|
  spec.name          = 'json_client'
  spec.version       = JsonClient::VERSION
  spec.authors       = ['johnmcconnell']
  spec.email         = ['johnnyillinois@gmail.com']
  spec.summary       = "crud json client to make creating services easy'"
  spec.description   = "crud json client to make creating services easy'"
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'attr_init'
  spec.add_dependency 'api-auth'

  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'coveralls'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rspec-collection_matchers'
  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'webmock'
end
