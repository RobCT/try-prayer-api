class AddColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :firstname, :string, defaults: ""
    add_column :users, :lastname, :string, defaults: ""
  end
end
