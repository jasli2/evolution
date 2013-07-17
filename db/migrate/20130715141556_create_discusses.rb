class CreateDiscusses < ActiveRecord::Migration
  def change
    create_table :discusses do |t|
      t.integer :user_id
      t.integer :course_class_id
      t.string :title

      t.timestamps
    end
  end
end
