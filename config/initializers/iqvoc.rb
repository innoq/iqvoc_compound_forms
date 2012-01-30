# initializer for both iqvoc and iqvoc_skosxl

require 'iqvoc/xllabel' # XXX: this basically duplicates iqvoc_skosxl's initializer - but is required to ensure correct loading order!?

Iqvoc.config.register_setting("title", "iQvoc Compound Forms")

Iqvoc::XLLabel.additional_association_class_names.
    merge!("CompoundForm::Base" => "domain_id",
        "CompoundForm::Content::Base" => "label_id") # used for the reverse direction ("compound_in")

Iqvoc::XLLabel.view_sections += ["compound_forms"]
