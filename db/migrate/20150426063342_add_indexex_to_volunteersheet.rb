class AddIndexexToVolunteersheet < ActiveRecord::Migration
  def change
    add_index :volunteersheets, :role_id
    add_foreign_key :volunteersheets, :roles
    add_index :volunteersheets, :person_id
    add_foreign_key :volunteersheets, :people
    add_index :volunteersheets, :event_id
    add_foreign_key :volunteersheets, :events    
  end
end
