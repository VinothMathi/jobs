class CreateJob < ActiveRecord::Migration[5.2]
  def change
    create_table :jobs do |t|
      t.integer  :schedule_id
      t.text     :job
      t.integer  :priority
      t.datetime :run_at
      t.string   :status
      t.text     :error
      t.timestamps
    end
    add_index :jobs, :schedule_id
    create_table :completed_jobs do |t|
      t.integer  :schedule_id
      t.datetime :run_at
      t.string   :status
      t.text     :error
      t.timestamps
    end
    add_index :completed_jobs, :schedule_id
  end
end
