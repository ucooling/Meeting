class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.integer :room_id
      t.integer :user_id
      t.string :schedule_day
      t.string :start_time
      t.string :end_time
      t.text :comment

      t.timestamps
    end
  end
end
