# == Schema Information
#
# Table name: examination_questions
#
#  id             :integer          not null, primary key
#  examination_id :integer
#  question_id    :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class ExaminationQuestion < ActiveRecord::Base
  attr_accessible :examination_id, :question_id

  validates :examination_id, :presence => true
  validates :question, :presence => true

  belongs_to :examination
  belongs_to :question

end
