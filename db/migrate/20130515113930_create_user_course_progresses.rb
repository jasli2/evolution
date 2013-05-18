class CreateUserCourseProgresses < ActiveRecord::Migration
  def change
    create_table :user_course_progresses do |t|
      t.integer :course_id
      t.integer :user_id
      t.string :course_progress

      t.timestamps
    end
  end
end
