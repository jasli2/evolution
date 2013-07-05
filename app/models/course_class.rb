# == Schema Information
#
# Table name: course_classes
#
#  id         :integer          not null, primary key
#  course_id  :integer
#  state      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CourseClass < ActiveRecord::Base
  attr_accessible :course_id
  validates :course_id, :presence => true
  
  belongs_to :course

  has_many :user_role_teachers, :class_name => 'ClassUserRole', :conditions => { :role => 'teacher' }
  has_many :teachers, :through => :user_role_teachers, :source => :user
  has_many :user_role_assistents, :class_name => 'ClassUserRole', :conditions => { :role => 'assistent' }
  has_many :assistents, :through => :user_role_teachers, :source => :user
  has_many :user_role_students, :class_name => 'ClassUserRole', :conditions => { :role => 'student' }
  has_many :students, :through => :user_role_teachers, :source => :user

  has_many :user_progresses, :class_name => 'UserClassProgress'

end
