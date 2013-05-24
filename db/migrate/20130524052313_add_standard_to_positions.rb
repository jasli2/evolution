class AddStandardToPositions < ActiveRecord::Migration
  def change
    add_column :positions, :standard, :integer
  end
end
