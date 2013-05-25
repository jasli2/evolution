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

class Course < ActiveRecord::Base
  attr_accessible :author, :filter_item, :title

  validate :author
  validate :filter_item
  validates :title, :presence => true

  has_many :activity_has_courses
  has_many :activities, :through => :activity_has_courses

  has_many :position_has_courses
  has_many :positions, :through => :position_has_courses

  has_many :competency_level_has_courses
  has_many :competency_levels, :through => :competency_level_has_courses

  has_many :user_course_progresses
  has_many :users, :through => :user_course_progresses

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |course|
        csv << course.attributes.values_at(*column_names)
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
      course.creator_id  = row[3]
      course.duration = row[4]
      course.course_type = row[5]
      course.teacher_id = row[7]
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



end
