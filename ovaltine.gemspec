# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ovaltine/version'

Gem::Specification.new do |spec|
  spec.name          = "ovaltine"
  spec.version       = Ovaltine::VERSION
  spec.authors       = ["thmsmlr"]
  spec.email         = ["millar.thomas@gmail.com"]
  spec.summary       = "Pull out your decoder rings kids, we're going to crack some codes"
  spec.description   = <<-DESC
This tool tries a variety of combination of different decoders to try to guess the encoding
of a string. There are a configurable set of checks which can be used to filter between bogus
and useful results.
DESC
  spec.homepage      = ""
  spec.license       = "MIT"
  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = "ovaltine"
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
