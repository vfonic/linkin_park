# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'linkin_park/version'

Gem::Specification.new do |spec|
  spec.name          = "linkin_park"
  spec.version       = LinkinPark::VERSION
  spec.authors       = ["Viktor Fonic"]
  spec.email         = ["viktor.fonic@gmail.com"]

  spec.summary       = %q{Linkin Park: a simple web crawler}
  spec.homepage      = "https://github.com/vfonic/linkin_park"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "thor", "~> 0.19.1"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", '~> 3.3.0'
  spec.add_development_dependency "shoulda-matchers"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "terminal-notifier-guard"
end
