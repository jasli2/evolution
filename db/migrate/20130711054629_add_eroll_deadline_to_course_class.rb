class AddErollDeadlineToCourseClass < ActiveRecord::Migration
  def change
    add_column :course_classes, :eroll_deadline, :datetime
  end
end
