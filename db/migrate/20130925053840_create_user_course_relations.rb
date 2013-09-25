class CreateUserCourseRelations < ActiveRecord::Migration
  def change
    create_table :user_course_relations do |t|
      t.integer :leader_id
      t.integer :follower_id

      t.timestamps
    end
  end
end
