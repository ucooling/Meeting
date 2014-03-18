class AddScheduleidToStatus < ActiveRecord::Migration
  def change
    add_column :statuses, :scheduleid, :integer
  end
end
