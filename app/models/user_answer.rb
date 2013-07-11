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
#  paper_id    :integer
#

class UserAnswer < ActiveRecord::Base
  attr_accessible :content, :correct

  belongs_to :question
  belongs_to :paper

end
