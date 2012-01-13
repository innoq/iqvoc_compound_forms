# encoding: UTF-8

require "active_support/concern"

module LabelExtensions
  extend ActiveSupport::Concern

  included do
    after_save do |label|
      # Compound forms
      # Only handle compound form creation if there are submitted widget values
      # Otherwise compound_forms would be destroyed on every save (e.g. in the branching process)!
      if inline_compound_form_origins.present?
        compound_forms.destroy_all
        inline_compound_form_origins.each do |origin_collection|
          compound_form_contents = []
          origin_collection.each_with_index do |origin, index|
            if label = Iqvoc::XLLabel.base_class.editor_selectable.by_origin(origin).last
              compound_form_contents << CompoundForm::Content::Base.new(:label => label, :order => index)
            end
          end
          compound_forms.create!(:compound_form_contents => compound_form_contents)
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
  end

  module InstanceMethods
    def compound_in
      CompoundForm::Base.joins(:compound_form_contents).
          where(:compound_form_contents => { :label_id => id }).
          includes(:domain).map(&:domain)
    end

    # Serialized setters and getters (\r\n or , separated)
    def inline_compound_form_origins
      @inline_compound_form_origins || []
    end

    def inline_compound_form_origins=(value_collection)
      # write to instance variable and write it on after_safe
      @inline_compound_form_origins = []

      value_collection.reject(&:blank?).each do |value|
        @inline_compound_form_origins << value.split(/\r\n|, */).map(&:strip). # XXX: use Iqvoc::InlineDataHelper?
            reject(&:blank?).uniq
      end
    end

    def compound_form_contents_size
      if @full_validation
        compound_forms.each do |cf|
          if cf.compound_form_contents.count < 2
            errors.add :base, I18n.t("txt.models.label.compound_form_contents_error")
          end
        end
      end
    end
  end
end
