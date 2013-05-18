class AddCourseIdAndAddActivityIdToActivityHasCourse < ActiveRecord::Migration
  def change
    add_column :activity_has_courses, :course_id, :Integer
    add_column :activity_has_courses, :activity_id, :Integer
  end
end
