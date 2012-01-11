# encoding: UTF-8

class CompoundForm::Base < ActiveRecord::Base
  class_attribute :rdf_namespace, :rdf_predicate
  self.rdf_namespace = 'umt'
  self.rdf_predicate = 'compoundForm'

  set_table_name 'compound_forms'

  belongs_to :domain, :class_name => 'Label::Base', :foreign_key => 'domain_id'

  has_many :compound_form_contents,
    :class_name  => 'CompoundForm::Content::Base',
    :foreign_key => 'compound_form_id',
    :dependent   => :destroy

  scope :published, includes(:domain).merge(Label::Base.published)

  def self.referenced_by(label_class)
    # To something with the label class
  end

  def self.deep_cloning_relations
    {self.name.to_relation_name => :compound_form_contents}
  end

  def self.view_section(obj)
    "compound_forms"
  end

  def self.view_section_sort_key(obj)
    100
  end

  def self.partial_name(obj)
    "partials/compound_form/base"
  end

  def self.edit_partial_name(obj)
    "partials/compound_form/edit_base"
  end

  def build_rdf(document, subject)
    subject.Umt.compoundForm(compound_form_contents.map {|cfc| IqRdf::build_uri(cfc.label.origin) })
  end

end

# integrate with Label -- XXX: down here to avoid load-order issues; hacky!?
require 'iqvoc_skosxl/label_extensions' # XXX: bad (ambiguous) name
