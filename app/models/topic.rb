class Topic < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :user
  has_many :comments, :as => :commentable, :dependent => :destroy

  validates :user_id, :title, :presence => true
  attr_accessible :title, :content
  
end
