# == Schema Information
#
# Table name: papers
#
#  id                      :integer          not null, primary key
#  score                   :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  user_id                 :integer
#  examination_id          :integer
#  examination_feedback_id :integer
#

class Paper < ActiveRecord::Base
  attr_accessible :correct_nums, :error_nums, :score, :user_id
  
  validates :examination_id, :presence => true
  validates :user_id, :presence => true

  belongs_to :user
  belongs_to :examination
  belongs_to :examination_feedback

  has_many :user_answers,  :dependent => :destroy
  has_one :feedback_todo, :class_name => "Todo", :as => :source,:conditions => {:todo_type => 'pending_finish'}

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

  #get paper correct/error numbers
  def get_answer_numbers(state)
    UserAnswer.get_answer_state_numbers(state).where(:id => self.id)
  end

end
