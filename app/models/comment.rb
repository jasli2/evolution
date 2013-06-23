# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  content          :text
#  user_id          :integer
#  commentable_type :string(255)
#  commentable_id   :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  repcomment_id    :integer
#

class Comment < ActiveRecord::Base
  # attr_accessible :title, :body

  after_create {
    Resque.enqueue(CommentSque, self.id)
  }

  belongs_to :user
  belongs_to :topic
  #belongs_to :respondent, :class_name => "User"
  belongs_to :commentable, :polymorphic => true
  has_many :replies, :class_name => "Comment", :foreign_key => 'repcomment_id'
  belongs_to :repcomment, :class_name => "Comment"
  has_one :feed_item, :as => :item, :dependent => :destroy

  validates :user_id, :commentable_id, :commentable_type, :repcomment_id, :content, :presence => true
  attr_accessible :content
  
  def gen_feed_item
    f = create_feed_item
    (user.fans).uniq.each {|u| u.feed_items << f}
  end

end
