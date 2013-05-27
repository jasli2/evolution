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
#  creator_id  :integer
#  duration    :integer
#  course_type :string(255)
#  teacher_id  :integer
#  description :string(255)
#

require 'file_size_validator'

class Course < ActiveRecord::Base
  paginates_per 10

  attr_accessible :title, :cover_image, :description, :duration, :creator_id, :teacher_id

  validates :title, :presence => true

  belongs_to :creator, :class_name => "User"
  belongs_to :teacher, :class_name => "User"

  has_many :activity_has_courses
  has_many :activities, :through => :activity_has_courses

  has_many :position_has_courses
  has_many :positions, :through => :position_has_courses

  has_many :competency_level_has_courses
  has_many :competency_levels, :through => :competency_level_has_courses

  has_many :user_course_progresses
  has_many :users, :through => :user_course_progresses


  # custom image sizes: each key is a version name
  IMAGE_CONFIG = {
    :crop => [4, 3],
    :large => [400, 300],
    :normal => [200, 150],
    :small => [100, 75]
  }
  mount_uploader :cover_image, ImageUploader
  validates :cover_image, :file_size => {:maximum => 2.megabytes.to_i }

  def self.to_csv(options = {})
    header = ["title", "description", "creator", "creator ID", "duration", "course type", \
              "Teacher", "TeacherID", "competency", "level"]
    CSV.generate(options) do |csv|
      csv << header
      all.each do |course|
        row_data = []
        row_data << course.title
        row_data << course.description
        row_data << course.creator.name
        row_data << course.creator.staff_id
        row_data << course.duration
        row_data << course.course_type
        row_data << course.teacher.name
        row_data << course.teacher.staff_id
        levels = course.competency_levels
        row_data << levels.first.competency.name
        row_data << levels.first.level

        csv << row_data
      end
    end
  end

  def self.save!(obj)
    begin
      obj.save!
    rescue RecordInvalid => error
    end
  end

  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    length = header.length
    course = Course.new
    (2..spreadsheet.last_row).each do |i|
      row = spreadsheet.row(i)
      course = Course.find_by_title(row[0]) || new
      course.title = row[0]
      course.description = row[1]
      creator = User.find_by_staff_id(row[3])
      course.creator_id  = creator.id
      course.duration = row[4]
      course.course_type = row[5]
      teacher = User.find_by_staff_id(row[7])
      course.teacher_id = teacher.id
      save!(course)
      competency = Competency.find_by_name(row[8])
      competency_level = competency.competency_levels.find_by_level(row[9])
      course.competency_level_has_courses.new(:competency_level_id=>competency_level.id,:course_id => course.id )
      save!(course)
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

  def self.for_position(p)
    includes(:competency_levels).where(:competency_levels => {:id => p.competency_level_ids}) if p
  end
end
