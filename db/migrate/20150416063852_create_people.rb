class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :firstname, defaults: ""
      t.string :lastname, defaults: ""

      t.timestamps null: false
    end
  end
end
