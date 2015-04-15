class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title, defaults: ""
      t.decimal :price, defaults: 0.0
      t.boolean :published, defaults: false
      t.integer :user_id

      t.timestamps
    end
    add_index :products, :user_id
  end
end
