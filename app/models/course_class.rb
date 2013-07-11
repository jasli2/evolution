# == Schema Information
#
# Table name: course_classes
#
#  id         :integer          not null, primary key
#  course_id  :integer
#  state      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  creator_id :integer
#  teach_date :datetime
#

class CourseClass < ActiveRecord::Base
  attr_accessible :course_id, :creator_id, :teach_date
  validates :course_id, :presence => true
  
  belongs_to :course
  belongs_to :creator, :class_name => 'User'

  has_many :user_role_teachers, :class_name => 'ClassUserRole', :conditions => { :role => 'teacher' }
  has_many :teachers, :through => :user_role_teachers, :source => :user
  has_many :user_role_assistents, :class_name => 'ClassUserRole', :conditions => { :role => 'assistent' }
  has_many :assistents, :through => :user_role_teachers, :source => :user
  has_many :user_role_students, :class_name => 'ClassUserRole', :conditions => { :role => 'student' }
  has_many :students, :through => :user_role_teachers, :source => :user

  has_many :user_progresses, :class_name => 'UserClassProgress'

  has_many :attachments, :as => :attachable

  # state machine
  state_machine :state, :initial => :erolling do 
    event :eroll_timeout do 
      transition :erolling => :eroll_done
    end

    event :finish do
      transition :eroll_done => :finished
    end

    event :cancel do
      transition any => :cancelled
    end
  end

  scope :active, where(:state => [:erolling, :eroll_done])
end
