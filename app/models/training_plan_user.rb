# == Schema Information
#
# Table name: training_plan_users
#
#  id               :integer          not null, primary key
#  training_plan_id :integer
#  user_id          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class TrainingPlanUser < ActiveRecord::Base
  attr_accessible :training_plan_id, :user_id

  validates :training_plan_id, :presence => true
  validates :user_id, :presence => true

  belongs_to :training_plan
  belongs_to :user
end
