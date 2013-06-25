# == Schema Information
#
# Table name: training_feedback_courses
#
#  id                        :integer          not null, primary key
#  training_plan_feedback_id :integer
#  course_id                 :integer
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#

class TrainingFeedbackCourse < ActiveRecord::Base
  attr_accessible :course_id, :training_plan_feedback_id

  belongs_to :course
  belongs_to :training_plan_feedback
end
