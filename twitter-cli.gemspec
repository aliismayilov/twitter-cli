# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'twitter/cli/version'

Gem::Specification.new do |spec|
  spec.name          = "twitter-cli"
  spec.version       = Twitter::Cli::VERSION
  spec.authors       = ["Ali Ismayilov"]
  spec.email         = ["ali@ismailov.info"]
  spec.summary       = %q{CLI to access Twitter API.}
  spec.homepage      = "https://github.com/aliismayilov/twitter-cli"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "httparty", "~> 0.13.1"
  spec.add_dependency "thor", "~> 0.19.1"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-its"
  spec.add_development_dependency "rspec-collection_matchers"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"
end
