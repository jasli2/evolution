# == Schema Information
#
# Table name: competencies
#
#  id          :integer          not null, primary key
#  name        :string(40)
#  description :string(255)
#  category_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Competency < ActiveRecord::Base
  attr_accessible :category, :description, :name

  validates :name, :presence => true, :uniqueness => true
  validates :description, :presence => true

  has_many :competency_levels
  has_many :competency_users
  has_many :users, :through => :competency_users

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |competency|
        csv << competency.attributes.values_at(*column_names)
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
    competency = Competency.new
    (2..spreadsheet.last_row).each do |i|
      row = spreadsheet.row(i);
      length = row.length
      unless (row[0].nil? || row[0].empty?)
        competency = Competency.find_by_name(row[0]) || Competency.new
        competency.name = row[0]
        competency.description = row[1]
        save!(competency)
      end

      competency_level = competency.competency_levels.new(:level => row[2], :description => row[3])
      save!(competency_level)
      ptr = 4
      while ptr < length  do
        unless (row[ptr].nil? || row[ptr].empty? || row[ptr.next].nil? || row[ptr.next].empty?)
          competency_level_requirement =  competency_level.competency_level_requirements.new(:description => row[ptr], :weight => row[ptr.next])
          save!(competency_level_requirement)
        end
        ptr += 2
      end

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
