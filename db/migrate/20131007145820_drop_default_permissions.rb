class DropDefaultPermissions < ActiveRecord::Migration
  def up
  	drop_table :default_permissions
  end

  def down
  end
end
