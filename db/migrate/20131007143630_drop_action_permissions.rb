class DropActionPermissions < ActiveRecord::Migration
  def up
  	drop_table :action_permissions
  end

  def down
  end
end
