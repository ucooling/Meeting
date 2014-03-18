class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.integer :room_id
      t.string :schedule_day
      t.string :start_time
      t.string :end_time

      t.timestamps
    end
  end
end
