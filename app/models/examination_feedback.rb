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
  attr_accessible :score

  validates :examination_id, :presence => true
  validates :user_id, :presence => true

  belongs_to :examination
  belongs_to :user

  has_many :user_answers,  :dependent => :destroy
  has_many :feedback_todo, :class_name => "Todo", :as => :source,:conditions => {:todo_type => 'pending_finish'}

  def get_answer_result(result)
    user_answers.answer_result(result)
  end

  def get_dialogical_result()
    user_answers - user_answers.answer_result(true) - user_answers.answer_result(false)
  end

  def get_answer_question_result(type, result)
    question = Array.new
    user_answers.answer_result(result).each do |answer|
      if answer.question.question_type_str == type
        question << answer.question
      end
    end
    return question
  end

  def get_answer_numbers(state)
    UserAnswer.answer_result(state).where(:id => self.id)
  end

  after_create :clear_feedback_todo, :feedback_callback

  private
    def clear_feedback_todo
      examination.feedback_todos.find_by_user_id(user_id).update_attributes(:finish_at => Time.zone.now)
    end

    def feedback_callback
      examination.feedback_created(self)
    end

end
