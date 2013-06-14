# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth/cookie/version'

Gem::Specification.new do |spec|
  spec.name          = "omniauth-cookie"
  spec.version       = Omniauth::Cookie::VERSION
  spec.authors       = ["Silas Baronda"]
  spec.email         = ["silas.baronda@gmail.com"]
  spec.description   = %q{Strategy to authenticate against cookie}
  spec.summary       = %q{Strategy to authenticate against cookie}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'omniauth', '~> 1.0'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
