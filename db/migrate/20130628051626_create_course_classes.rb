class CreateCourseClasses < ActiveRecord::Migration
  def change
    create_table :course_classes do |t|
      t.integer :course_id
      t.string :state

      t.timestamps
    end
  end
end
