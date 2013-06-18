# == Schema Information
#
# Table name: questions
#
#  id             :integer          not null, primary key
#  qdata          :text
#  answer         :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  examination_id :integer
#

class Question < ActiveRecord::Base
  attr_accessible :answer, :qdata

  validates :answer, :presence => true
  validates :qdata, :presence => true

  belongs_to :examination

end
