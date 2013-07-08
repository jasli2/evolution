class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :source_type
      t.integer :source_id
      t.string :notification_type
      t.datetime :viewed_at
      t.integer :user_id

      t.timestamps
    end
  end
end
