class CreateModelPermissions < ActiveRecord::Migration
  def change
    create_table :model_permissions do |t|
      t.integer :user_id
      t.string :model_name

      t.timestamps
    end
  end
end
