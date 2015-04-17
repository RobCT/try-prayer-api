class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :description, defaults: ""

      t.timestamps null: false
    end
  end
end
