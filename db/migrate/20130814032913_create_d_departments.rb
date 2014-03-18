class CreateDDepartments < ActiveRecord::Migration
  def change
    create_table :d_departments do |t|
      t.integer :key
      t.string :value

      t.timestamps
    end
  end
end
