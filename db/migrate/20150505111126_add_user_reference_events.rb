class AddUserReferenceEvents < ActiveRecord::Migration
  change_table :events do |t|
    t.references :user, index: true, foreign_key: true
    t.column :is_private, :boolean, default: false
    t.remove :created_by, :last_modified_by
  end
end
