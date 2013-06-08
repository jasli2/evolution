class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.integer :user_id
      t.integer :feed_item_id

      t.timestamps
    end

  add_index :feeds, [:user_id, :feed_item_id]
  end
end
