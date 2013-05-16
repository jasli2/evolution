# == Schema Information
#
# Table name: courses
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  author      :string(255)
#  filter_item :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Course < ActiveRecord::Base
  attr_accessible :author, :filter_item, :title

  validates :author, :presence => true
  validates :filter_item, :presence => true
  validates :title, :presence => true

  has_many :activity_has_courses
  has_many :activities, :through => :activity_has_courses

  has_many :position_has_courses
  has_many :positions, :through => :position_has_courses

  has_many :competency_level_has_courses
  has_many :competency_levels, :through => :competency_level_has_courses

  has_many :user_course_progresses
  has_many :users, :through => :user_course_progresses


end
