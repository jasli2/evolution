class CreateUserRelations < ActiveRecord::Migration
  def change
    create_table :user_relations do |t|
      t.integer     :leader_id
      t.integer     :follower_id
      t.timestamps
    end

    add_index :user_relations, :leader_id
    add_index :user_relations, :follower_id
    add_index :user_relations, [:leader_id, :follower_id], :unique => true
  end
end
