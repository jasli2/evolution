class CreateActivityHasUsers < ActiveRecord::Migration
  def change
    create_table :activity_has_users do |t|

      t.timestamps
    end
  end
end
