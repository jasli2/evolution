class CreateTrainingPlanCourses < ActiveRecord::Migration
  def change
    create_table :training_plan_courses do |t|
      t.integer :training_plan_id
      t.integer :course_id
      t.integer :course_type

      t.timestamps
    end
  end
end
