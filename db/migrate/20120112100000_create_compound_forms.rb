class CreateCompoundForms < ActiveRecord::Migration

  def self.up
    unless table_exists? "compound_form_contents"
      create_table "compound_form_contents", :force => false do |t|
        t.timestamps
        t.integer "compound_form_id"
        t.integer "label_id"
        t.integer "order"
      end
    end
    unless table_exists? "compound_forms"
      create_table "compound_forms", :force => false do |t|
        t.timestamps
        t.integer "domain_id"
      end
    end

    unless index_exists?("compound_forms", "domain_id", :name => "ix_cf_fk")
      add_index "compound_forms", "domain_id", :name => "ix_cf_fk"
    end
    unless index_exists?("compound_form_contents", "compound_form_id", :name => "ix_cfc_compound_form_id")
      add_index "compound_form_contents", "compound_form_id", :name => "ix_cfc_compound_form_id"
    end
    unless index_exists?("compound_form_contents", "label_id", :name => "ix_cfc_label_id")
      add_index "compound_form_contents", "label_id", :name => "ix_cfc_label_id"
    end
  end

  def self.down
    # we don't want to delete existing data
  end

end
