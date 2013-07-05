# == Schema Information
#
# Table name: user_class_progresses
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  course_class_id  :integer
#  training_plan_id :integer
#  progress         :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class UserClassProgress < ActiveRecord::Base
  attr_accessible :course_class_id, :progress, :training_plan_id, :user_id

  validates :user_id, :presence => true
  validates :course_class_id, :presence => true

  belongs_to :course_class
  belongs_to :user
  belongs_to :training_plan_id
end
