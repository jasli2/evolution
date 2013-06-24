class TrainingPlanCourse < ActiveRecord::Base
  attr_accessible :course_id, :course_type, :training_plan_id

  belongs_to :training_plan
  belongs_to :course
  
end
