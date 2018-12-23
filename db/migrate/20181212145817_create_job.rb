class CreateJob < ActiveRecord::Migration[5.2]
  def change
    create_table :delayed_jobs do |t|
      t.integer  :schedule_id
      t.integer  :event_id
      t.text     :handler
      t.integer  :priority
      t.integer  :attempts, default: 0
      t.string   :queue
      t.datetime :run_at
      t.string   :status
      t.string   :locked_by
      t.datetime :locked_at
      t.datetime :failed_at
      t.text     :error
      t.timestamps
    end
    add_index :delayed_jobs, :schedule_id
    create_table :jobs_logs do |t|
      t.integer  :schedule_id
      t.integer  :event_id
      t.text     :handler
      t.integer  :priority
      t.integer  :attempts
      t.string   :queue
      t.datetime :run_at
      t.string   :status
      t.string   :locked_by
      t.datetime :locked_at
      t.datetime :failed_at
      t.text     :error
      t.timestamps
    end
    add_index :jobs_logs, :schedule_id
  end
end
