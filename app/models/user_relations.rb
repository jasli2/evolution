class UserRelation < ActiveRecord::Base
  attr_accessible :leader_id, :follower_id

  validates :leader_id, :presence => true
  validates :follower_id, :presence => true

  belongs_to :leader, :class_name => 'User'
  belongs_to :follower, :class_name => 'User'

end
