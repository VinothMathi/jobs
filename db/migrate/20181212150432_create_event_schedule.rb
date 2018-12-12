class CreateEventSchedule < ActiveRecord::Migration[5.2]
  def change
    create_table :events_schedules do |t|
      t.integer :event_id
      t.integer :schedule_id
    end
    add_index :events_schedules, [:event_id, :schedule_id]
  end
end
