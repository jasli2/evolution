class CreatePositionHasCourses < ActiveRecord::Migration
  def change
    create_table :position_has_courses do |t|
      t.integer :position_id
      t.integer :course_id

      t.timestamps
    end
  end
end
