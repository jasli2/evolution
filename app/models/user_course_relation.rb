class UserCourseRelation < ActiveRecord::Base
  attr_accessible :follower_id, :leader_id

  after_create {
    Resque.enqueue(UserCourseSque, self.id)
  }

  validates :leader_id, :presence => true
  validates :follower_id, :presence => true


  belongs_to :leader, :class_name => 'Course'
  belongs_to :follower, :class_name => 'User'

  has_one :feed_item, :as => :item, :dependent => :destroy

  def gen_feed_item
    f = create_feed_item
    (follower.fans).each {|u| u.feed_items << f}
  end


end
