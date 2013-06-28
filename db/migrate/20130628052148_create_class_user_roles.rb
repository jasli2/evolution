class CreateClassUserRoles < ActiveRecord::Migration
  def change
    create_table :class_user_roles do |t|
      t.integer :course_class_id
      t.integer :user_id
      t.string :role

      t.timestamps
    end
  end
end
