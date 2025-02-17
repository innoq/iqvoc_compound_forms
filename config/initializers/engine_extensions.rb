# encoding: UTF-8
Rails.application.config.to_prepare do
  Label::Skosxl::Base.send(:include, CompoundFormsLabelExtensions)
end
