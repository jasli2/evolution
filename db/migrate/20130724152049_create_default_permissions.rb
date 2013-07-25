class CreateDefaultPermissions < ActiveRecord::Migration
  def change
    create_table :default_permissions do |t|
      t.string :role
      t.string :model_name
      t.integer :create_permit
      t.integer :edit_permit
      t.integer :read_permit

      t.timestamps
    end
  end
end
