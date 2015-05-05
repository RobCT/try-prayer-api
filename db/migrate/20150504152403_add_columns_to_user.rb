class AddColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :username, :string, defaults: ""
  end
end
