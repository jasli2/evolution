# == Schema Information
#
# Table name: competency_level_has_courses
#
#  id                  :integer          not null, primary key
#  competency_level_id :integer
#  course_id           :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class CompetencyLevelHasCourse < ActiveRecord::Base
  attr_accessible :competency_level_id, :course_id

  validates :competency_level_id, :presence => true
  validates :course_id, :presence =>  true

  belongs_to :competency_level
  belongs_to :course

end
