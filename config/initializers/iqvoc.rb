# initializer for both iqvoc and iqvoc_skosxl

# This basically duplicates iqvoc_skosxl's initializer — but is required to
# ensure correct loading order!?
require 'iqvoc/xllabel'

Iqvoc.config.register_setting("title", "iQvoc Compound Forms")

Iqvoc::Xllabel.additional_association_class_names.
    merge!("CompoundForm::Base" => { foreign_key: "domain_id", inverse_of: :domain },
        # used for the reverse direction ("compound_in")
        "CompoundForm::Content::Base" => { foreign_key: "label_id", inverse_of: :label })

Iqvoc::Xllabel.view_sections += ["compound_forms"]

ActiveSupport.on_load :skos_importer do
  SkosImporter.second_level_object_classes.delete(CompoundForm::Content::Base)
end
