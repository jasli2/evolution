# == Schema Information
#
# Table name: discusses
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  course_class_id :integer
#  title           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Discuss < ActiveRecord::Base
  attr_accessible :course_class_id, :title, :user_id

  belongs_to :course_class
  belongs_to :user

  validates :course_class_id, :presence => true
  validates :user_id, :presence => true
  validates :title, :presence => true

  has_many :comments, :as => :commentable
end
