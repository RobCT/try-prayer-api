class CreateTemplates < ActiveRecord::Migration
  def change
    create_table :templates do |t|
      t.string :title, default: "", null: false

      t.timestamps null: false
    end
  end
end
