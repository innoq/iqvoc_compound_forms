# encoding: UTF-8

class CompoundForm::Base < ApplicationRecord
  class_attribute :rdf_namespace, :rdf_predicate
  self.rdf_namespace = 'iqvoc'
  self.rdf_predicate = 'compoundFrom'

  self.table_name ='compound_forms'

  belongs_to :domain, :class_name => 'Label::Base', :foreign_key => 'domain_id'

  has_many :compound_form_contents,
           class_name: 'CompoundForm::Content::Base',
           foreign_key: 'compound_form_id',
           dependent: :destroy,
           inverse_of: :compound_form

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

  def self.build_from_rdf(rdf_subject, rdf_predicate, rdf_object)
    unless rdf_subject.is_a? Label::SKOSXL::Base
      raise "#{self.name}#build_from_rdf: Subject (#{rdf_subject}) must be a 'Label::SKOSXL::Base'"
    end

    target_class = RDFAPI::PREDICATE_DICTIONARY[rdf_predicate] || self

    ActiveRecord::Base.transaction do
      begin
        compound_form = target_class.create(domain: rdf_subject) # create compound form
        create_compound_form_contents(rdf_object, compound_form)
      rescue Exception => e
        raise ActiveRecord::Rollback, e
      end
    end

  end

  def build_rdf(document, subject)
    subject.send(rdf_namespace).send(rdf_predicate, compound_form_contents.map {|cfc| IqRdf::build_uri(cfc.label.origin) })
  end

  private

  def self.create_compound_form_contents(rdf_object, compound_form)
    rdf_object.each do |obj|
      case obj.last
        when String # normal
          if obj.last =~ /^:(.*)$/
            # we are responsible for this (e.g. :computer-de)
            label = Iqvoc::XLLabel.base_class.by_origin(obj.last[1..-1]).last # find label by origin, strip out leading ':'

            if label
              CompoundForm::Content::Base.create(label: label, compound_form: compound_form)
            else
              raise "#{self.name}#create_compound_form_contents: Could not create compound form content. Cannot find label with origin '#{obj.last}'"
            end
          end
        when Array # another blank note
          # call recursively
          create_compound_form_contents(obj.last, compound_form)
      end
    end
  end
end
