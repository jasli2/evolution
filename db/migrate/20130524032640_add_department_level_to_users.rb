class AddDepartmentLevelToUsers < ActiveRecord::Migration
  def change
    add_column :users, :department_level, :integer
  end
end
