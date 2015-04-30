class AddTemplateReferenceVolunteersheet < ActiveRecord::Migration
  change_table :volunteersheets do |t|
    t.references :template, index: true, foreign_key: true
  end
end
