class ChangeUserNumberToString < ActiveRecord::Migration
  def up
      change_column :users, :number,:string
  end

  def down
     change_column :users, :number,:integer
  end
end
