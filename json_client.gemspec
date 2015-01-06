# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'json_client/version'

Gem::Specification.new do |spec|
  spec.name          = "json_client"
  spec.version       = JsonClient::VERSION
  spec.authors       = ["johnmcconnell"]
  spec.email         = ["johnnyillinois@gmail.com"]
  spec.summary       = %q{crud json client to make creating services easy'}
  spec.description   = %q{crud json client to make creating services easy'}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'rest-client', '~> 1.7.2'

  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-collection_matchers"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"
end
