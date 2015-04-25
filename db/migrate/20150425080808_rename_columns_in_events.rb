class RenameColumnsInEvents < ActiveRecord::Migration
  change_table :events do |t|
    t.rename :date, :eventdate
    t.rename :start, :eventstart
    t.rename :end, :eventend
  end
end
