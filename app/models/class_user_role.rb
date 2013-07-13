# == Schema Information
#
# Table name: class_user_roles
#
#  id              :integer          not null, primary key
#  course_class_id :integer
#  user_id         :integer
#  role            :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class ClassUserRole < ActiveRecord::Base
  attr_accessible :course_class_id, :role, :user_id
  
  ROLES = %w(teacher assistent student)

  validates :user_id, :presence => true
  validates :course_class_id, :presence => true
  validates :role, :inclusion => { :in => ROLES }

  belongs_to :course_class
  belongs_to :user

  after_create :gen_notification, :if => Proc.new { |r| ['teacher', 'assistent'].include? r.role }
  after_create :gen_user_progress, :if => Proc.new { |r| r.role == 'student' }
  before_destroy :remove_user_progess, :if => Proc.new { |r| r.role == 'student' }

  def gen_notification
    user.notifications.create!(:source => course_class, :notification_type => 'assign_' + self.role)
  end

  def gen_user_progress
    tp = user.training_plan_for_course(self.course_class.course)
    if tp
      #tp.each do |t|
        user.class_progresses.create!(:course_class_id => self.course_class_id, :training_plan_id => tp.id)
      #end
    else
      user.class_progresses.create!(:course_class_id => self.course_class_id)
    end
  end

  def remove_user_progess
    user.class_progresses.find_by_course_class_id(self.id).destroy
  end
end
