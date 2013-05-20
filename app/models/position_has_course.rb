# == Schema Information
#
# Table name: position_has_courses
#
#  id          :integer          not null, primary key
#  position_id :integer
#  course_id   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class PositionHasCourse < ActiveRecord::Base
  attr_accessible :course_id, :position_id

  validates :course_id, :presence => true
  validates :position_id, :presence => true

  belongs_to :position
  belongs_to :course

end
