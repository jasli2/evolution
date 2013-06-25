class TrainingFeedbackCourse < ActiveRecord::Base
  attr_accessible :course_id, :training_plan_feedback_id

  belongs_to :course
  belongs_to :training_plan_feedback
end
