# == Schema Information
#
# Table name: examination_users
#
#  id             :integer          not null, primary key
#  examination_id :integer
#  user_id        :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class ExaminationUser < ActiveRecord::Base
  attr_accessible :examination_id, :user_id
  validates :examination_id, :presence => true
  validates :user_id, :presence => true

  belongs_to :examination
  belongs_to :user
end
