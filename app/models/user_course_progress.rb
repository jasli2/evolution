# == Schema Information
#
# Table name: user_course_progresses
#
#  id              :integer          not null, primary key
#  course_id       :integer
#  user_id         :integer
#  course_progress :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class UserCourseProgress < ActiveRecord::Base
  attr_accessible :course_id, :course_progress, :user_id

  validates :course_id, :presence => true
  validates :user_id, :presence => true
  validates :course_progress, :presence => true

  belongs_to :user;
  belongs_to :course;

end
