# == Schema Information
#
# Table name: examination_feedbacks
#
#  id             :integer          not null, primary key
#  examination_id :integer
#  user_id        :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class ExaminationFeedback < ActiveRecord::Base
  attr_accessible :examination_id, :user_id

  validates :examination_id, :presence => true
  validates :user_id, :presence => true

  belongs_to :examination
  belongs_to :user

  after_create :clear_feedback_todo, :feedback_callback

  private
    def clear_feedback_todo
      examination.feedback_todos.find_by_user_id(user_id).update_attributes(:finish_at => Time.zone.new)
    end

    def feedback_callback
      examination.feedback_created(self)
    end

end
