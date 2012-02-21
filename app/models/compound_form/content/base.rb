# encoding: UTF-8

class CompoundForm::Content::Base < ActiveRecord::Base

  self.table_name ='compound_form_contents'

  belongs_to :compound_form, :class_name => 'CompoundForm::Base', :foreign_key => 'compound_form_id'
  belongs_to :label,         :class_name => 'Label::Base', :foreign_key => 'label_id'

  def self.label_published
    includes(:label).merge(Label::Base.published)
  end

  def self.target_in_edit_mode(domain_id)
    joins(:compound_form, :label).
    includes(:label).
    where("(compound_forms.domain_id = ?) AND (labels.locked_by IS NOT NULL)", domain_id)
  end

  def self.referenced_by(label_class)
    # To something with the label class
  end

  def self.deep_cloning_relations
    self.name.to_relation_name
  end

  def self.view_section(obj)
    "compound_forms"
  end

  def self.view_section_sort_key(obj)
    200
  end

  def self.partial_name(obj)
    "partials/compound_form/content/base"
  end

  def self.edit_partial_name(obj)
    "partials/compound_form/content/base" # Show data only
  end

  def build_rdf(document, subject)
    #
  end

end
