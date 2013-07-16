class CreateActionPermissions < ActiveRecord::Migration
  def change
    create_table :action_permissions do |t|
      t.integer :model_permission_id
      t.string :action_name
      t.integer :user_scope

      t.timestamps
    end
  end
end
