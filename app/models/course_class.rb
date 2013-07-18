# == Schema Information
#
# Table name: course_classes
#
#  id             :integer          not null, primary key
#  course_id      :integer
#  state          :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  creator_id     :integer
#  teach_date     :datetime
#  eroll_deadline :datetime
#  max_students   :integer
#  start_time     :datetime
#  end_time       :datetime
#  address        :string(255)
#

class CourseClass < ActiveRecord::Base
  attr_accessible :course_id, :creator_id, :teach_date, :eroll_deadline, :max_students
  attr_accessible :start_time, :end_time, :address
  validates :course_id, :presence => true
  validates :creator_id, :presence => true
  validates :max_students, :presence => true
  validate :start_and_end_time
  
  belongs_to :course
  belongs_to :creator, :class_name => 'User'

  has_many :class_user_roles
  has_many :users, :through => :class_user_roles
  has_many :user_role_teachers, :class_name => 'ClassUserRole', :conditions => { :role => 'teacher' }
  has_many :teachers, :through => :user_role_teachers, :source => :user
  has_many :user_role_assistents, :class_name => 'ClassUserRole', :conditions => { :role => 'assistent' }
  has_many :assistents, :through => :user_role_assistents, :source => :user
  has_many :user_role_students, :class_name => 'ClassUserRole', :conditions => { :role => 'student' }
  has_many :students, :through => :user_role_students, :source => :user

  attr_accessible :teacher_ids, :assistent_ids, :student_ids

  has_many :user_progresses, :class_name => 'UserClassProgress'

  has_many :attachments, :as => :attachable
  accepts_nested_attributes_for :attachments, :reject_if => proc { |a| a['file'].blank? }
  attr_accessible :attachments_attributes

  has_many :discusses

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

  def eroll(u)
    students << u if u
  end

  def uneroll(u)
    user_role_students.find_by_user_id(u.id).destroy if u
  end

  def full?
    students.count >= max_students
  end

  def creator?(u)
    creator_id == u.id if u
  end

  def teacher?(u)
    teacher_ids.include? u.id if u
  end

  def assistent?(u)
    assistent_ids.include? u.id if u
  end

  def student?(u)
    student_ids.include? u.id if u
  end

  private
  def start_and_end_time
    if start_time or end_time
      if start_time and !end_time
        errors.add(:end_time, I18n.t("end time is not precent"))
      elsif end_time and !start_time
        errors.add(:start_time, I18n.t("start time is not precent"))
      else
      end
    end
  end
end



