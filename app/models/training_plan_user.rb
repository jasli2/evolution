class TrainingPlanUser < ActiveRecord::Base
  attr_accessible :training_plan_id, :user_id

  belongs_to :training_plan
  belongs_to :user
end
