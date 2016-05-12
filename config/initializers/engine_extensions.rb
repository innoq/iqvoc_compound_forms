# encoding: UTF-8

require "iqvoc/compound_forms/label_extensions"

Rails.application.config.to_prepare do
  Label::SKOSXL::Base.send(:include, CompoundFormsLabelExtensions)
end
