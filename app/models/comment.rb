class Comment < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :user
  belongs_to :commentable, :polymorphic => true

  validates :user_id, :commentable_id, :commentable_type, :content, :presence => true
  attr_accessible :content
  
end
