# encoding: UTF-8

# Copyright 2011-2014 innoQ Deutschland GmbH
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require File.expand_path('../../test_helper', __FILE__)
require 'iqvoc/skos_importer'

class SkosImporterTest < ActiveSupport::TestCase

  test 'compound forms import' do
    test_data = File.open(File.expand_path('../../fixtures/hobbies.nt', __FILE__))
    @importer = Iqvoc::SkosImporter.new(test_data, 'http://hobbies.com/')

    assert_equal 0, CompoundForm::Base.count
    assert_equal 0, CompoundForm::Content::Base.count

    @importer.run

    assert_equal 1, CompoundForm::Base.count
    assert_equal 3, CompoundForm::Content::Base.count

    compound_form = CompoundForm::Base.first
    assert_equal 'computer_programming-en', compound_form.domain.origin
    assert_equal 3, compound_form.compound_form_contents.size

    cfc1, cfc2, cfc3 = *compound_form.compound_form_contents
    assert_equal 'computer-en', cfc1.label.origin
    assert_equal 'programming-en', cfc2.label.origin
    assert_equal 'cool-en', cfc3.label.origin
  end

  test 'invalid compound forms import ' do
    test_data = (<<-DATA
      <http://hobbies.com/computer_programming> <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://www.w3.org/2004/02/skos/core#Concept> .
      <http://hobbies.com/computer_programming> <http://www.w3.org/2008/05/skos-xl#prefLabel> <http://hobbies.com/computer_programming-en> .
      <http://hobbies.com/computer_programming-en> <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://www.w3.org/2008/05/skos-xl#Label> .
      <http://hobbies.com/computer_programming-en> <http://www.w3.org/2008/05/skos-xl#literalForm> "Computer programming"@en .
      <http://hobbies.com/computer-en> <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://www.w3.org/2008/05/skos-xl#Label> .
      <http://hobbies.com/computer-en> <http://www.w3.org/2008/05/skos-xl#literalForm> "Computer"@en .
      <http://hobbies.com/programming-en> <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://www.w3.org/2008/05/skos-xl#Label> .
      <http://hobbies.com/programming-en> <http://www.w3.org/2008/05/skos-xl#literalForm> "Programming"@en .
      <http://hobbies.com/computer_programming-en> <http://try.iqvoc.net/schema#compoundForm> _:b3 .
      _:b3 <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://www.w3.org/1999/02/22-rdf-syntax-ns#List> .
      _:b3 <http://www.w3.org/1999/02/22-rdf-syntax-ns#first> <http://hobbies.com/computer-en> .
      _:b3 <http://www.w3.org/1999/02/22-rdf-syntax-ns#rest> _:b4 .
      _:b4 <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://www.w3.org/1999/02/22-rdf-syntax-ns#List> .
      _:b4 <http://www.w3.org/1999/02/22-rdf-syntax-ns#first> <http://hobbies.com/programmig3rw8uoosgriohgrhoigrwhiogrwohiwgrouhgwrouhgwohuwrgohuwgrohiwgorihhoiwgrdhkjbnng-en> .
      _:b4 <http://www.w3.org/1999/02/22-rdf-syntax-ns#rest> <http://www.w3.org/1999/02/22-rdf-syntax-ns#nil> .
    DATA
    ).split("\n")

    @importer = Iqvoc::SkosImporter.new(test_data, 'http://hobbies.com/')
    assert_equal 0, CompoundForm::Base.count
    assert_equal 0, CompoundForm::Content::Base.count

    @importer.run

    assert_equal 0, CompoundForm::Base.count
    assert_equal 0, CompoundForm::Content::Base.count
  end
end
