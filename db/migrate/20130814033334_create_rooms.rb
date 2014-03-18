class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :room_name
      t.integer :room_floor
      t.string :tv_ip
      t.boolean :tv
      t.boolean :projector
      t.boolean :pc
      t.boolean :webcam
      t.boolean :tel
      t.boolean :sound_proofing
      t.boolean :air_condition
      t.boolean :whiteboard
      t.integer :max_volume
      t.string :tel_num

      t.timestamps
    end
  end
end
