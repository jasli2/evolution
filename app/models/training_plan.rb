class TrainingPlan < ActiveRecord::Base
  attr_accessible :title, :feedback_deadline, :end_day, :status
  attr_accessible :required_course_min, :required_course_max, :optional_course_min, :optional_course_max

  has_many :training_plan_users
  has_many :users, :through => :training_plan_users

  has_many :training_plan_courses
  has_many :courses, :through => :training_plan_courses

  has_many :training_plan_feedbacks
  has_many :feedbacks, :through => :training_plan_feedbacks

end
