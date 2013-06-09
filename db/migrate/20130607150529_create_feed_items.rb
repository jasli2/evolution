class CreateFeedItems < ActiveRecord::Migration
  def change
    create_table :feed_items do |t|
      t.references :item, :polymorphic => true
      t.timestamps
    end

    add_index :feed_items, [:item_id, :item_type]
  end
end
