# encoding: UTF-8

require File.expand_path('../../test_helper', __FILE__)
require 'iqvoc/skos_importer'

class SkosImporterTest < ActiveSupport::TestCase

  setup do
    TEST_DATA = File.open(File.expand_path('../../fixtures/hobbies.nt', __FILE__))
    @importer = Iqvoc::SkosImporter.new(TEST_DATA, 'http://hobbies.com#')
  end

  test 'compound forms import' do
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

  # test 'invalid compound forms import ' do
  #   # test transaction funtionality
  # end
end
