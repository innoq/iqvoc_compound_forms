# encoding: UTF-8

$:.push File.expand_path("../lib", __FILE__)
require "iqvoc/compound_forms/version"

Gem::Specification.new do |s|
  s.name        = "iqvoc_compound_forms"
  s.version     = Iqvoc::CompoundForms::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Robert Glaser", "Till Schulte-Coerne", "Frederik Dohr"]
  s.email       = ["robert.glaser@innoq.com"]
  s.homepage    = "" # TODO
  s.summary     = "" # TODO
  s.description = "" # TODO

  s.rubyforge_project = "iqvoc_compound_forms"

  s.add_dependency "rails", "~> 3.1.3"
  s.add_dependency "iqvoc"
  s.add_dependency "iqvoc_skosxl"

  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = ["lib"]
end
