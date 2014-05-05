# encoding: UTF-8

class CompoundForm::Base < ActiveRecord::Base
  class_attribute :rdf_namespace, :rdf_predicate
  self.rdf_namespace = 'iqvoc'
  self.rdf_predicate = 'compoundForm'

  self.table_name ='compound_forms'

  belongs_to :domain, :class_name => 'Label::Base', :foreign_key => 'domain_id'

  has_many :compound_form_contents,
    :class_name  => 'CompoundForm::Content::Base',
    :foreign_key => 'compound_form_id',
    :dependent   => :destroy

  def self.published
    includes(:domain).references(:labels).merge(Label::Base.published)
  end

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
    subject.send(rdf_namespace).send(rdf_predicate, compound_form_contents.map {|cfc| IqRdf::build_uri(cfc.label.origin) })
  end

end
