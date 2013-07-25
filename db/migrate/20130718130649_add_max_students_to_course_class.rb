class AddMaxStudentsToCourseClass < ActiveRecord::Migration
  def change
    add_column :course_classes, :max_students, :integer
    add_column :course_classes, :start_time, :datetime
    add_column :course_classes, :end_time, :datetime
    add_column :course_classes, :address, :string
  end
end
