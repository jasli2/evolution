# == Schema Information
#
# Table name: user_answers
#
#  id          :integer          not null, primary key
#  content     :string(255)
#  correct     :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  question_id :integer
#  examination_feedback_id    :integer
#

class UserAnswer < ActiveRecord::Base
  attr_accessible :content, :correct, :examination_feedback_id

  validates :question_id , :presence => true
  validates :examination_feedback_id , :presence => true

  belongs_to :question
  belongs_to :examination_feedback

  scope :answer_result, lambda {|state| where(:correct => state)}
  scope :get_user_answer, lambda{|type| where(:content => type)}
  scope :get_all_answer, lambda{|qid| where(:question_id => qid) }

end
