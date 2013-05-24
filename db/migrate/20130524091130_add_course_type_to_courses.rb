class AddCourseTypeToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :course_type, :string
  end
end
