class CreateBDepartments < ActiveRecord::Migration
  def change
    create_table :b_departments do |t|
      t.integer :key
      t.string :value

      t.timestamps
    end
  end
end
