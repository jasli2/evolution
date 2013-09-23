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

  def self.to_csv(export_mode, options = {})
    header = ["competency_name","description","level","level_description"]
    i = 1;
    while i < 7 do
      header << "level_requirement_" + i.to_s
      header << "Weight_" + i.to_s
      i += 1
    end
    CSV.generate(options) do |csv|
      csv << header

      if export_mode.blank?
        Competency.order(:id).each do |competency|
          competency.competency_levels.order(:level).each do |levels|
            row_data = []
            row_data << competency.name
            row_data << competency.description
            row_data << levels.level
            row_data << levels.description
            levels.competency_level_requirements.order(:weight).each do |requirements|
              row_data << requirements.description
              row_data << requirements.weight
            end
            csv << row_data
          end
        end
      end
    end
  end

  def self.save!(obj, error_info = nil)
    begin
      obj.save!
    rescue
      #error_info["error_action"]["fail_name"] = competency.name
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

    competency = Competency.new
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header,spreadsheet.row(i)].transpose]
      name = row.first[0]

      unless (row[name].nil? || row[name].empty?)
        competency = Competency.find_by_name(row[name]) || Competency.new
        competency.name = row[name]
        competency.description = row["description"]
        save!(competency, error_info)
        if error_info["error_num"] != count
          count = error_info["error_num"]
          next
        end
      end

      competency_level = competency.competency_levels.new(:level => row["level"], :description => row["level_description"])
      save!(competency_level, error_info)
      if error_info["error_num"] != count 
        count = error_info["error_num"]
        next
      end
      ptr = 1
      num = (length - 4) / 2
      while ptr <= num  do
        unless (row["level_requirement_" + ptr.to_s ].nil? || row["level_requirement_" + ptr.to_s].empty? \
                || row["Weight_" + ptr.to_s].nil? || row["Weight_" + ptr.to_s].empty?)
          competency_level_requirement =  competency_level.competency_level_requirements.new(:description => row["level_requirement_" + ptr.to_s],\
                                                                                              :weight => row["Weight_" + ptr.to_s])
          save!(competency_level_requirement)
        end
        ptr += 1
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
