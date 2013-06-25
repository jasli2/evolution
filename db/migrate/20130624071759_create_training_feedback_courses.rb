class CreateTrainingFeedbackCourses < ActiveRecord::Migration
  def change
    create_table :training_feedback_courses do |t|
      t.integer :training_plan_feedback_id
      t.integer :course_id

      t.timestamps
    end
  end
end
