# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'b2/version'

Gem::Specification.new do |spec|
  spec.name          = "b2"
  spec.version       = B2::VERSION
  spec.authors       = ["Muhammad Bayu"]
  spec.email         = ["metalkoholic@gmail.com"]

  spec.summary       = %q{ruby wrapper for backblaze b2 API}
  spec.homepage      = "https://github.com/metalkoholic/b2"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  
  
  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_runtime_dependency "httparty", "~> 0.13"
  spec.required_ruby_version = '>= 2.1.0'
end
