class CreateVolunteersheets < ActiveRecord::Migration
  def change
    create_table :volunteersheets do |t|
      t.string :about, default: ""
      t.integer :rowindex, default: 1, null: false
      t.references :role
      t.references :person
      t.references :event

      t.timestamps null: false
    end
  end
end
