class AddPositionIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :position_id, :integer
  end
end
