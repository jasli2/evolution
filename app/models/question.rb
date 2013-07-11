# == Schema Information
#
# Table name: questions
#
#  id            :integer          not null, primary key
#  qdata         :text
#  answer        :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  correct       :boolean
#  question_type :integer
#

class Question < ActiveRecord::Base
  attr_accessible :answer, :qdata, :question_type_str

  validates :answer, :presence => true
  validates :qdata, :presence => true
  validates :question_type_str, :inclusion => { :in => [:choice, :judgement, :dialogical], :message => "%{value} is not a valid question type"}
  #validates :type, :presence => true

  has_many :examination_questions
  has_many :examinations, :through => :examination_questions

  has_many :user_answers

  QUESTION_TYPE = [:choice, :judgement, :dialogical]

  def question_type_str
    QUESTION_TYPE[self.question_type] if self.question_type
  end

  def question_type_str=(c_type)
    if QUESTION_TYPE.index(c_type.to_sym)
      self.question_type = QUESTION_TYPE.index(c_type.to_sym)
    else
      self.question_type = nil
    end
  end

end
