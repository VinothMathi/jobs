class CreateSchedule < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|
      t.integer :priority
      t.string  :status
      t.string  :cron_schedule
      t.string  :queue
      t.text    :job
      t.integer :user_id
      t.integer :last_updated_by_id
      t.timestamps
    end
    add_index :schedules, :status
  end
end
