# == Schema Information
#
# Table name: competency_users
#
#  id              :integer          not null, primary key
#  self_eval_level :integer
#  mgr_eval_level  :integer
#  user_id         :integer
#  competency_id   :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class CompetencyUser < ActiveRecord::Base
  attr_accessible :competency_id, :mgr_eval_level, :self_eval_level, :user_id

  validates :competency_id, :presence => true
  validates :mgr_eval_level, :presence => true
  validates :self_eval_level, :presence => true
  validates :user_id, :presence => true

  belongs_to :competency
  belongs_to :user

end
