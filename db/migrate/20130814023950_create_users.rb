class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :number
      t.string :name
      t.string :email
      t.string :tel
      t.integer :b_department
      t.integer :d_department
      t.integer :position
      t.integer :user_type
      t.string :password
      t.boolean :admin

      t.timestamps
    end
  end
end
