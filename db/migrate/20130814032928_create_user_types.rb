class CreateUserTypes < ActiveRecord::Migration
  def change
    create_table :user_types do |t|
      t.integer :key
      t.string :value

      t.timestamps
    end
  end
end
