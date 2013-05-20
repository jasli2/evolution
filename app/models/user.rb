# == Schema Information
#
# Table name: users
#
#  id          :integer          not null, primary key
#  first_name  :string(24)       not null
#  last_name   :string(24)       not null
#  email       :string(128)      not null
#  manager_id  :integer
#  birthday    :date
#  joined_at   :date
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  position_id :integer
#

class User < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation
  has_secure_password

  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validate :password, :presence => true, :length => { minimum: 6}
  validate :password_confirmation, :presence => true
  validates :email,
    :presence => true, 
    :uniqueness => {case_sensitive: false},
    :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "Not a valid email address!" }

  before_save { |user| user.email = email.downcase}

  has_many :subordinates, :class_name => "User", :foreign_key => "manager_id"
  belongs_to :manager, :class_name => "User"
  belongs_to :position

  has_many :competency_users
  has_many :competencies, :through => :competency_users

  has_many :user_course_progresses
  has_many :courses, :through => :user_course_progresses

  validates :position, :presence => true

  def fullname
    [first_name, last_name].join " "
  end
end
