# == Schema Information
#
# Table name: courses
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  creator_id  :integer
#  duration    :integer
#  course_type :string(255)
#  teacher_id  :integer
#  description :text
#  cover_image :string(255)
#  audience    :string(255)
#  target      :string(255)
#  teach_type  :string(255)
#  source_type :string(255)
#  lesson      :string(255)
#

require 'file_size_validator'

class Course < ActiveRecord::Base
  paginates_per 5

  attr_accessible :title, :cover_image, :description, :duration, :creator_id, :teacher_id
  attr_accessible :course_type, :audience, :target, :teach_type, :source_type, :lesson

  validates :title, :presence => true

  belongs_to :creator, :class_name => "User"
  belongs_to :teacher, :class_name => "User"

  validates :creator, :presence => true

  has_many :activity_has_courses
  has_many :activities, :through => :activity_has_courses

  has_many :position_has_courses
  has_many :positions, :through => :position_has_courses

  has_many :competency_level_has_courses
  has_many :competency_levels, :through => :competency_level_has_courses

  has_many :user_course_progresses
  has_many :users, :through => :user_course_progresses

  has_many :training_plan_courses
  has_many :training_plans, :through => :training_plan_courses
  has_many :training_feedback_courses
  has_many :training_feedbacks, :through => :training_feedback_courses, :source => :training_plan_feedback

  has_many :course_classes

  mount_uploader :lesson, FileUploader

  # custom image sizes: each key is a version name
  IMAGE_CONFIG = {
      :crop => [4, 3],
      :large => [400, 300],
      :normal => [200, 150],
      :small => [100, 75]
  }
  mount_uploader :cover_image, ImageUploader
  validates :cover_image, :file_size => {:maximum => 2.megabytes.to_i }

  #scopes
  scope :for_teacher, lambda { |u| where( :teacher_id => u.id ) if u }
  def self.for_position(p)
    includes(:competency_levels).where(:competency_levels => {:id => p.competency_level_ids}) if p
  end

  def teacher?(u)
    teacher_id == u.id
  end

  def creator?(u)
    creator.id == u.id
  end

  def state
    course_classes.active.count > 0 ? 'open' : 'closed'
  end

  def find_class_for_user(u)
    if u
      course_classes.each do |cc|
        return cc if cc.student_ids.include? u.id
      end

      nil
    end
  end

  def self.to_csv(options = {})
    header = ["title","audience", "type", "sourcetype", "coursetype", "creator", "creator ID", \
              "duration", "Teacher", "competency", "level"]
    CSV.generate(options) do |csv|
      csv << header
      all.each do |course|
        row_data = []
        row_data << course.title
        puts course.title
        row_data << course.audience
        row_data << course.teach_type
        row_data << course.source_type
        row_data << course.course_type

        row_data << course.creator.name
        row_data << course.creator.staff_id
        row_data << (course.duration / 60.0)

        row_data << course.teacher.name
        levels = course.competency_levels

        if (!levels.empty? && !levels.nil?)
          row_data << levels.first.competency.name
          row_data << levels.first.level
        else
          row_data << " "
          row_data << " "
        end

        csv << row_data
      end
    end
  end

  def self.save!(obj, error_info = nil)
    begin
      obj.save!
    rescue 
      if error_info != nil
        error_info["error_num"] = error_info["error_num"] + 1
      end  
    end
  end

  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    length = header.length
    #for error info
    count = 0
    error_info = Hash.new
    error_name = Hash.new
    error_info["error_action"] = error_name
    error_info["error_num"] = count
    error_info["total"] = spreadsheet.last_row - 1

    #course = Course.new
    (2..spreadsheet.last_row).each do |i|
      #row = spreadsheet.row(i)
      row = Hash[[header,spreadsheet.row(i)].transpose]
      title = row.first[0]


      course = Course.find_by_title(row[title]) || new
      course.title = row[title]
      course.audience = row["audience"]
      course.teach_type = row["type"]
      course.source_type = row["sourcetype"]
      course.course_type = row["coursetype"]
      creator = User.find_by_name(row["creator"])
      unless (creator.nil?)
        course.creator_id  = creator.id
      end
      course.duration = (row["duration"].to_f * 60).to_i
      teacher = User.find_by_name(row["Teacher"])
      course.teacher_id = teacher.id
      save!(course, error_info)
      if error_info["error_num"] != count
        count = error_info["error_num"]
        next
      end
      competency = Competency.find_by_name(row["competency"])
      unless (competency.nil?)
        competency_level = competency.competency_levels.find_by_level(row["level"])
        course.competency_level_has_courses.new(:competency_level_id=>competency_level.id,:course_id => course.id )
      end
      save!(course)
      if error_info["error_num"] != count
        count = error_info["error_num"]
        next
      end
    end

    return error_info
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
