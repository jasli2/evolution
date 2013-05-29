# == Schema Information
#
# Table name: user_relations
#
#  id          :integer          not null, primary key
#  leader_id   :integer
#  follower_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class UserRelation < ActiveRecord::Base
  attr_accessible :leader_id, :follower_id

  validates :leader_id, :presence => true
  validates :follower_id, :presence => true

  belongs_to :leader, :class_name => 'User'
  belongs_to :follower, :class_name => 'User'

end
