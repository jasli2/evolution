#encoding: utf-8
# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string(128)      not null
#  manager_id      :integer
#  birthday        :date
#  joined_at       :date
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  position_id     :integer
#  password_digest :string(255)
#  name            :string(255)
#

class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation, :position_id

  has_secure_password
  validates :name, :presence => true
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
  attr_accessible :position

  has_many :competency_users
  has_many :competencies, :through => :competency_users

  has_many :user_course_progresses
  has_many :courses, :through => :user_course_progresses

  validates :position_id, :presence => true

  def fullname
    name
  end

  def self.auth(email, password)
    user = User.find_by_email(email.downcase)
    if user && user.authenticate(password)
      user
    else
      nil
    end
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
      row = Hash[[header, spreadsheet.row(i)].transpose]
      user = find_by_email(row["email"]) || new
      accessible_attributes.delete("password_digest")
      user.attributes = row.to_hash.slice(*accessible_attributes)
      user.password = "12345"
      user.password_confirmation = "12345"
      user.save!
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
