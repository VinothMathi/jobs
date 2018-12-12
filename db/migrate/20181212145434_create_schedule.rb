class CreateSchedule < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|
      t.integer :priority
      t.string  :status
      t.string  :cron_schedule
      t.text    :job
      t.timestamps
    end
    add_index :schedules, :status
  end
end
