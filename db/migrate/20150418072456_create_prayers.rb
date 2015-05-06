class CreatePrayers < ActiveRecord::Migration

  def change
    create_table :prayers do |t|
      t.text :title, defaults: ""
      t.date :prayerdate, defaults: Date.today
      t.text :prayer, defaults: ""
      t.belongs_to :user, index: true, foreign_key: true
      t.timestamps null: false
      
    end
  end
end
