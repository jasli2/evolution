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
require "feeditem_sque.rb"

class UserRelation < ActiveRecord::Base
  attr_accessible :leader_id, :follower_id

  after_create {
  	Resque.enqueue(FeedItemSque, self.id)
  }

  validates :leader_id, :presence => true
  validates :follower_id, :presence => true

  belongs_to :leader, :class_name => 'User'
  belongs_to :follower, :class_name => 'User'

  has_one :feed_item, :as => :item, :dependent => :destroy

  def gen_feed_item
  	f = create_feed_item
  	(follower.fans).each {|u| u.feed_items << f}
  end
end
