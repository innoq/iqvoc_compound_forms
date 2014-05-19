# encoding: UTF-8

require File.expand_path('../../test_helper', __FILE__)
require 'iqvoc/skos_importer'

class SkosImporterTest < ActiveSupport::TestCase

  test 'compound forms import' do
    test_data = File.open(File.expand_path('../../fixtures/hobbies.nt', __FILE__))
    @importer = Iqvoc::SkosImporter.new(test_data, 'http://hobbies.com#')

    assert_equal 0, CompoundForm::Base.count
    assert_equal 0, CompoundForm::Content::Base.count

    @importer.run

    assert_equal 1, CompoundForm::Base.count
    assert_equal 2, CompoundForm::Content::Base.count

    compound_form = CompoundForm::Base.first
    assert_equal 'computer_programming-en', compound_form.domain.origin
    assert_equal 2, compound_form.compound_form_contents.size

    cfc1, cfc2 = *compound_form.compound_form_contents
    assert_equal 'computer-en', cfc1.label.origin
    assert_equal 0, cfc1.order
    assert_equal 'programming-en', cfc2.label.origin
    assert_equal 1, cfc2.order
  end

  test 'invalid compound forms import ' do
    test_data = (<<-DATA
      <http://hobbies.com#computer_programming> <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://www.w3.org/2004/02/skos/core#Concept> .
      <http://hobbies.com#computer_programming> <http://www.w3.org/2008/05/skos-xl#prefLabel> <http://hobbies.com#computer_programming-en> .
      <http://hobbies.com#computer_programming-en> <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://www.w3.org/2008/05/skos-xl#Label> .
      <http://hobbies.com#computer_programming-en> <http://www.w3.org/2008/05/skos-xl#literalForm> "Computer programming"@en .
      <http://hobbies.com#computer-en> <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://www.w3.org/2008/05/skos-xl#Label> .
      <http://hobbies.com#computer-en> <http://www.w3.org/2008/05/skos-xl#literalForm> "Computer"@en .
      <http://hobbies.com#programming-en> <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://www.w3.org/2008/05/skos-xl#Label> .
      <http://hobbies.com#programming-en> <http://www.w3.org/2008/05/skos-xl#literalForm> "Programming"@en .
      <http://hobbies.com#computer_programming-en> <http://try.iqvoc.net/schema#compoundForm> _:b3 .
      _:b3 <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://www.w3.org/1999/02/22-rdf-syntax-ns#List> .
      _:b3 <http://www.w3.org/1999/02/22-rdf-syntax-ns#first> <http://hobbies.com#computer-en> .
      _:b3 <http://www.w3.org/1999/02/22-rdf-syntax-ns#rest> _:b4 .
      _:b4 <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://www.w3.org/1999/02/22-rdf-syntax-ns#List> .
      _:b4 <http://www.w3.org/1999/02/22-rdf-syntax-ns#first> <http://hobbies.com#programmig3rw8uoosgriohgrhoigrwhiogrwohiwgrouhgwrouhgwohuwrgohuwgrohiwgorihhoiwgrdhkjbnng-en> .
      _:b4 <http://www.w3.org/1999/02/22-rdf-syntax-ns#rest> <http://www.w3.org/1999/02/22-rdf-syntax-ns#nil> .
    DATA
    ).split("\n")

    @importer = Iqvoc::SkosImporter.new(test_data, 'http://hobbies.com#')
    assert_equal 0, CompoundForm::Base.count
    assert_equal 0, CompoundForm::Content::Base.count

    @importer.run

    assert_equal 0, CompoundForm::Base.count
    assert_equal 0, CompoundForm::Content::Base.count
  end
end
