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
  
  ROLES = %w(teacher, assistent, student)

  validates :user_id, :presence => true
  validates :course_class_id, :presence => true
  validates :role, :inclusion => { :in => ROLES }

  belongs_to :course_class
  belongs_to :user
end
