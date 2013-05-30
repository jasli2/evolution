class AddIsAssessedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_assessed, :boolean, :default => false
  end
end
