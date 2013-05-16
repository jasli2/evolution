class CreateCompetencyLevelHasCourses < ActiveRecord::Migration
  def change
    create_table :competency_level_has_courses do |t|
      t.integer :competency_level_id
      t.integer :course_id

      t.timestamps
    end
  end
end
