# encoding: UTF-8

$:.push File.expand_path('../lib', __FILE__)
require 'iqvoc/compound_forms/version'

Gem::Specification.new do |s|
  s.name        = 'iqvoc_compound_forms'
  s.version     = Iqvoc::CompoundForms::VERSION
  s.platform    = Gem::Platform::RUBY
  s.required_ruby_version = '>= 3.3'
  s.authors     = ['Robert Glaser', 'Till Schulte-Coerne', 'Frederik Dohr']
  s.email       = ['robert.glaser@innoq.com']
  s.homepage    = 'https://github.com/innoq/iqvoc_compound_forms'
  s.summary     = 'iQvoc compound forms extension'
  s.description = 'Compound forms extension for iQvoc SKOS-XL vocabulary management system built on the Semantic Web'
  s.license     = 'Apache-2.0'

  s.add_dependency 'iqvoc', '~> 4.17.0'
  s.add_dependency 'iqvoc_skosxl', '~> 2.13.0'

  s.files = `git ls-files -z -- README.md Gemfile Rakefile iqvoc_compound_forms.gemspec app config db lib test`.split("\0")
  s.test_files = s.files.grep(%r{^test/})
  s.require_paths = ['lib']
end
