# == Schema Information
#
# Table name: positions
#
#  id          :integer          not null, primary key
#  name        :string(40)
#  description :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  standard    :integer
#

class Position < ActiveRecord::Base
  attr_accessible :description, :name, :standard

  validates :name, :presence => true, :uniqueness => true

  has_many :position_competency_levels
  has_many :competency_levels, :through => :position_competency_levels
  has_many :users

  def self.to_csv(export_mode, options = {})
    header = ["name", "description", "Standard"]
    i = 1
    while i < 7 do
      header << "competency_" + i.to_s
      header << "level_" + i.to_s
      i += 1
    end

    CSV.generate(options) do |csv|
      csv << header
      if export_mode.blank?
        all.each do |position|
          row_data = []
          row_data << position.name
          row_data << position.description
          row_data << position.standard
          position.competency_levels.each do |levels|
            row_data << levels.competency.name
            row_data << levels.level
          end
          csv << row_data
        end
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

    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header,spreadsheet.row(i)].transpose]
      name = row.first[0]

      position = find_by_name(row[name]) || new
      position.name = row[name]
      position.description = row["description"]
      position.standard = row["Standard"]
      save!(position, error_info)
      if error_info["error_num"] != count
        count = error_info["error_num"]
        next
      end
      #position.save!

      i = 1
      num = (length - 3) / 3
      while i <= num do
        competency = Competency.find_by_name(row["competency_" + i.to_s ])
        competency_level = competency.competency_levels.find_by_level(row["level_" + i.to_s])

        pcl = position.position_competency_levels.build(:position_id => position.id, :standard => row["Standard_" + i.to_s],\
                                                        :competency_level_id => competency_level.id)
        #save!(pcl)
        if pcl.save
          puts "position_competency_levels saved success"
        else
          #add error info 
        end

        i += 1
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
