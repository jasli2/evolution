class AddCreatorIdToCourseClass < ActiveRecord::Migration
  def change
    add_column :course_classes, :creator_id, :integer
    add_column :course_classes, :teach_date, :datetime
  end
end
