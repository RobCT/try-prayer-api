class CreateVolunteerSheets < ActiveRecord::Migration
  def change
    create_table :volunteer_sheets do |t|
      t.string :about
      t.integer :rowindex

      t.timestamps null: false
    end
  end
end
