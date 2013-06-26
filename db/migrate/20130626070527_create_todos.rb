class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.string :source_type
      t.integer :source_id
      t.datetime :finish_at
      t.datetime :deadline
      t.string :todo_type
      t.integer :user_id

      t.timestamps
    end
  end
end
