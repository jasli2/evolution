class AddActivityIdAndUserIdToActivityHasUser < ActiveRecord::Migration
  def change
    add_column :activity_has_users, :activity_id, :Integer
    add_column :activity_has_users, :user_id, :Integer
  end
end
