class CreatePermissionRoles < ActiveRecord::Migration
  def change
    create_table :permission_roles do |t|
      t.integer :user_id
      t.string :role

      t.timestamps
    end
  end
end
