class Discuss < ActiveRecord::Base
  attr_accessible :course_class_id, :title, :user_id

  belongs_to :course_class
  belongs_to :user

  validates :course_class_id, :presence => true
  validates :user_id, :presence => true
  validates :title, :presence => true

  has_many :comments, :as => :commentable
end
