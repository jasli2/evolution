# == Schema Information
#
# Table name: activity_has_courses
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  course_id   :integer
#  activity_id :integer
#

class ActivityHasCourse < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :course_id, :activity_id

  validates :course_id, :presence => true
  validates :activity_id, :presence => true

  belongs_to :course;
  belongs_to :activity;
end
