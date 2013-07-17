# == Schema Information
#
# Table name: papers
#
#  id             :integer          not null, primary key
#  score          :integer
#  correct_nums   :integer
#  error_nums     :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :integer
#  examination_id :integer
#

class Paper < ActiveRecord::Base
  attr_accessible :correct_nums, :error_nums, :score, :user_id
  
  validates :examination_id, :presence => true
  validates :user_id, :presence => true

  belongs_to :users
  belongs_to :examination
  belongs_to :examination_feedback

  has_many :user_answers,  :dependent => :destroy

  #get paper correct/error numbers
  def get_answer_numbers(state)
    UserAnswer.get_answer_state_numbers(state).where(:id => self.id)
  end

end
