class AddFkConstraintsIqvocCompoundForms < ActiveRecord::Migration[4.2]
  def change
    add_foreign_key :compound_forms, :labels, column: 'domain_id', on_update: :cascade, on_delete: :cascade
    add_foreign_key :compound_form_contents, :compound_forms, column: 'compound_form_id', on_update: :cascade, on_delete: :cascade
    add_foreign_key :compound_form_contents, :labels, column: 'label_id', on_update: :cascade, on_delete: :cascade
  end
end
