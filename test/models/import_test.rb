# encoding: UTF-8

require File.expand_path('../../test_helper', __FILE__)
require 'iqvoc/skos_importer'

class SkosImporterTest < ActiveSupport::TestCase
  TEST_DATA = File.open(File.expand_path("../../fixtures/hobbies.nt", __FILE__))

  setup do
    @importer = Iqvoc::SkosImporter.new(TEST_DATA, "http://hobbies.com#")
  end

  test "import compound forms" do
    @importer.run
  end
end
