class AddModuleNameToPermissionRole < ActiveRecord::Migration
  def change
  	add_column :permission_roles, :module_name, :string
  end
end
