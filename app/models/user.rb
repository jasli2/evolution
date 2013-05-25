# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  email            :string(128)      not null
#  manager_id       :integer
#  birthday         :date
#  joined_at        :date
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  position_id      :integer
#  password_digest  :string(255)
#  name             :string(255)
#  is_admin         :boolean          default(FALSE)
#  avatar           :string(255)
#  staff_id         :integer
#  phone_num        :integer
#  mobile_phone     :integer
#  department       :string(255)
#  department_level :integer
#

require 'file_size_validator'

class User < ActiveRecord::Base

  attr_accessible :name, :email, :password, :password_confirmation, :position_id, :avatar
  attr_accessible :manager_id,:birthday, :joined_at, :phone_num, :mobile_phone, :staff_id
  attr_accessible :department, :department_level

  has_secure_password

  validates :name, :presence => true
  validates :password, :presence => true, :length => { minimum: 6}, :on => :create
  validates :password_confirmation, :presence => true, :on => :create
  validates :email,
    :presence => true, 
    :uniqueness => {case_sensitive: false},
    :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "Not a valid email address!" }

  before_save { |user| user.email = email.downcase}

  has_many :subordinates, :class_name => "User", :foreign_key => "manager_id"
  belongs_to :manager, :class_name => "User"
  belongs_to :teacher

  belongs_to :position
  attr_accessible :position

  has_many :course, :foreign_key => "creator_id"
  has_many :course, :foreign_key =>  "teacher_id"

  has_many :competency_users
  has_many :competencies, :through => :competency_users

  has_many :user_course_progresses
  has_many :courses, :through => :user_course_progresses

  validates :position_id, :presence => true

  scope :staff, where(:is_admin => false)

  # custom image sizes: each key is a version name
  IMAGE_CONFIG = {
    :crop => [1, 1],
    :large => [200, 200],
    :normal => [100, 100],
    :small => [50, 50]
  }
  mount_uploader :avatar, ImageUploader
  validates :avatar, :file_size => {:maximum => 1.megabytes.to_i }

  def admin?
    self.is_admin
  end

  def self.auth(email, password)
    user = User.find_by_email(email.downcase)
    if user && user.authenticate(password)
      user
    else
      nil
    end
  end

  def get_position_courses(number)
    c = []
    self.position.competency_levels.each do |cl|
      c = ( c + cl.courses ).uniq
    end

    c.sort! { |x,y| x.id <=> y.id }

    last = number > c.size ? c.size : number
    c[0..last-1]
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      column_names.delete("password_digest")
      csv << column_names
      all.each do |user|
        #puts *column_names
        csv << user.attributes.values_at(*column_names)
      end
    end
  end

  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      #row = Hash[[header,spreadsheet.row(i)].transpose]
      row = spreadsheet.row(i)
      user = find_by_email(row[2]) || new

      position = Position.find_by_name(row[8])

      user.password = "123456"
      user.password_confirmation = "123456"
      user.name = row[0]
      user.email = row[2]
      user.position_id = position.id
      user.save!
      user.staff_id = row[1]
      user.phone_num = row[3]
      user.mobile_phone = row[4]
      user.manager = User.find_by_name(row[5])
      user.manager_id = row[6]
      user.birthday = row[7]
      user.department = row[10]
      user.department_level = row[11]
      user.joined_at = row[12]
      user.save!
      position.users << user

      #user.positoin.competency_levels

    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
      when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
      when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
      when ".csv" then Roo::Csv.new(file.path, nil, :ignore)
      else raise "Unknown file type: #{file.original_filename}"
    end
  end

end
