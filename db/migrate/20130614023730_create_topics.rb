class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
	  t.integer :user_id
	  t.string :title
	  t.text :content

      t.timestamps
    end
    add_index :topics, :user_id
    add_index :topics, :updated_at
  end
end
