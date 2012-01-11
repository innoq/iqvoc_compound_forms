# encoding: UTF-8

require File.join(File.expand_path(File.dirname(__FILE__)), '../test_helper')

class CompoundFormTest < ActiveSupport::TestCase

  setup do
    @compounds = {
      "Weltraumkampfpilot" => %w(Weltraum Kampf Pilot)
    }
  end

  test "instance creation" do
    @compounds.each do |term, components|
      label = Iqvoc::XLLabel.base_class.create!(:value => term,
          "origin" => OriginMapping.merge(term),
          "language" => Iqvoc::Concept.pref_labeling_languages.first,
          "published_at" => 2.days.ago)
      label.compound_forms.create!(:compound_form_contents => components.
          each_with_index.map { |cterm, i|
            clabel = Iqvoc::XLLabel.base_class.create!(:value => cterm,
                "origin" => OriginMapping.merge(cterm),
                "language" => Iqvoc::Concept.pref_labeling_languages.first,
                "published_at" => 2.days.ago)
            CompoundForm::Content::Base.new(:label => clabel, :order => i)
          })
    end

    assert_equal 4, Label::Base.count
    assert_equal 1, CompoundForm::Base.count
    assert_equal 3, CompoundForm::Content::Base.count

    label = Label::Base.find_by_value("Weltraumkampfpilot")
    assert_equal 1, label.compound_forms.count
    assert_equal %w(Weltraum Kampf Pilot), label.compound_forms.first.
        compound_form_contents.map { |cfc| cfc.label.value }

    %w(Weltraum Kampf Pilot).each { |term|
      sublabel = Label::Base.find_by_value(term)
      assert_equal 1, sublabel.compound_in.count
      assert_equal label, sublabel.compound_in.first
    }
  end

  test "inline assignment" do
    terms = @compounds.map { |term, components|
      [term] + components
    }.flatten
    labels = terms.map { |term|
      Iqvoc::XLLabel.base_class.create!(:value => term,
          "origin" => OriginMapping.merge(term),
          "language" => Iqvoc::Concept.pref_labeling_languages.first,
          "published_at" => 2.days.ago)
    }

    label = labels.first
    inline_values = labels[1...labels.length].map(&:origin).join(",")
    label.inline_compound_form_origins = [inline_values]
    label.save

    assert_equal 4, Label::Base.count
    assert_equal 1, CompoundForm::Base.count
    assert_equal 3, CompoundForm::Content::Base.count

    label = Label::Base.find_by_value("Weltraumkampfpilot")
    assert_equal 1, label.compound_forms.count
    assert_equal %w(Weltraum Kampf Pilot), label.compound_forms.first.
        compound_form_contents.map { |cfc| cfc.label.value }

    %w(Weltraum Kampf Pilot).each { |term|
      sublabel = Label::Base.find_by_value(term)
      assert_equal 1, sublabel.compound_in.count
      assert_equal label, sublabel.compound_in.first
    }
  end

end
