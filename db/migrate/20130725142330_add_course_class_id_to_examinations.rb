class AddCourseClassIdToExaminations < ActiveRecord::Migration
  def change
    add_column :examinations, :course_class_id, :integer
  end
end
