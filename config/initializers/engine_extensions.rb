# encoding: UTF-8
Rails.application.config.to_prepare do
  Label::SKOSXL::Base.send(:include, CompoundFormsLabelExtensions)
end
