class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.integer :key
      t.string :value

      t.timestamps
    end
  end
end
