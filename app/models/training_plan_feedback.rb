# == Schema Information
#
# Table name: training_plan_feedbacks
#
#  id               :integer          not null, primary key
#  training_plan_id :integer
#  user_id          :integer
#  note             :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class TrainingPlanFeedback < ActiveRecord::Base
  attr_accessible :training_plan_id, :user_id, :note

  validates :training_plan_id, :presence => true
  validates :user_id, :presence => true

  belongs_to :training_plan
  belongs_to :user

  has_many :training_feedback_courses
  has_many :courses, :through => :training_feedback_courses

  scope :for_plan, lambda { |p| where( :training_plan_id => p.id ) if p }

  after_create :clear_feedback_todo

  private
    def clear_feedback_todo
      training_plan.feedback_todos.find_by_user_id(user_id).update_attributes(:finish_at => Time.zone.now)
    end
end
