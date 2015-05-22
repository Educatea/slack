# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'slack/version'

Gem::Specification.new do |spec|
  spec.name          = "slack"
  spec.version       = Slack::VERSION
  spec.authors       = ["Juan Gesino"]
  spec.email         = ["jgesino@educatea.com.ar"]
  spec.summary       = %q{Simple Ruby wrapper for Slack's Real Time Messaging API using bots.}
  spec.description   = %q{Simple Ruby wrapper for Slack's Real Time Messaging API using bots.}
  spec.homepage      = "http://educatea.com.ar"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
