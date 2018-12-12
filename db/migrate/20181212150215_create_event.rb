class CreateEvent < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :code
      t.string :name
      t.string :status
      t.timestamps
    end
    add_index :events, [:code, :status]
  end
end