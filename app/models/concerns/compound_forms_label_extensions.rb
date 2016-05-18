# encoding: UTF-8

require "active_support/concern"

module CompoundFormsLabelExtensions
  extend ActiveSupport::Concern

  included do
    after_save do |label|
      # Compound forms
      # Only handle compound form creation if there are submitted widget values
      # Otherwise compound_forms would be destroyed on every save (e.g. in the branching process)!
      if inline_compound_form_origins.any?
        transaction do
          compound_forms.destroy_all
          inline_compound_form_origins.each do |origin_collection|
            compound_form_contents = []
            origin_collection.each_with_index do |origin, index|
              if label = Iqvoc::XLLabel.base_class.editor_selectable.by_origin(origin).last
                compound_form_contents << CompoundForm::Content::Base.new(:label => label, :order => index)
              end
            end
            if compound_form_contents.any?
              compound_forms.create!(:compound_form_contents => compound_form_contents)
            end
          end
        end
      end
    end

    has_many :compound_forms,
        :class_name  => "CompoundForm::Base",
        :foreign_key => "domain_id",
        :dependent   => :destroy

    has_many :compound_form_contents,
        :through    => :compound_forms,
        :class_name => "CompoundForm::Content::Base",
        :dependent  => :destroy

    validate :compound_form_contents_size
    validate :compound_form_contents_languages
    validate :compound_form_contents_self_reference
  end

  def compound_in
    # FIXME: sort with database function
    CompoundForm::Base.joins(:compound_form_contents)
      .where(:compound_form_contents => { :label_id => id })
      .includes(:domain).map(&:domain).sort_by(&:value)
  end

  # Serialized setters and getters (\r\n or , separated)
  def inline_compound_form_origins
    @inline_compound_form_origins || []
  end

  def inline_compound_form_origins=(value_collection)
    # write to instance variable and write it on after_safe
    @inline_compound_form_origins ||= []

    value_collection.reject(&:blank?).each do |value|
      @inline_compound_form_origins << value.split(/\r\n|, */).map(&:strip).
          reject(&:blank?).uniq
    end
  end

  def compound_form_contents_size
    if validatable_for_publishing?
      compound_forms.each do |cf|
        if cf.compound_form_contents.count < 2
          errors.add :base, I18n.t("txt.models.label.compound_form_contents_size_error")
        end
      end
    end
  end

  def compound_form_contents_languages
    if validatable_for_publishing?
      compound_form_contents.each do |cfc|
        if cfc.label.language != language
          errors.add :base, I18n.t("txt.models.label.compound_form_contents_language_error")
          break
        end
      end
    end
  end

  def compound_form_contents_self_reference
    if validatable_for_publishing?
      cfc_label_ids = compound_form_contents.map {|cfc| cfc.label_id }
      if cfc_label_ids.include? published_version_id
        errors.add :base, I18n.t("txt.models.label.compound_form_contents_self_reference_error")
      end
    end
  end


end
