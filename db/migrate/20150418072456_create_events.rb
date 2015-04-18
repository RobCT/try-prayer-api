class CreateEvents < ActiveRecord::Migration

  def change
    create_table :events do |t|
      t.text :title, defaults: ""
      t.date :date, defaults: Date.today
      t.time :start, defaults: Time.new("00:00") 
      t.time :end, defaults: Time.new("00:00")  
      t.text :created_by, defaults: ""
      t.text :last_modified_by, defaults: ""

      t.timestamps null: false
      
    end
  end
end
