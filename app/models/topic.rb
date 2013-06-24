# == Schema Information
#
# Table name: topics
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  title      :string(255)
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Topic < ActiveRecord::Base
  # attr_accessible :title, :body
  paginates_per 5
  
  after_create {
    Resque.enqueue(TopicSque, self.id)   
  }

  belongs_to :user
  has_many :comments, :as => :commentable, :dependent => :destroy
  has_one :feed_item, :as => :item, :dependent => :destroy

  validates :user_id, :title, :presence => true
  attr_accessible :title, :content

  def gen_feed_item
    f = create_feed_item
    (user.fans).uniq.each {|u| u.feed_items << f }
  end
  
end
