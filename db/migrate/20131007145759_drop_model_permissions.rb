class DropModelPermissions < ActiveRecord::Migration
  def up
  	drop_table :model_permissions
  end

  def down
  end
end
