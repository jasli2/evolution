class TrainingPlanFeedback < ActiveRecord::Base
  attr_accessible :training_plan_id, :user_id, :note

  has_many :training_feedback_courses
  has_many :courses, :through => :training_feedback_courses
end
