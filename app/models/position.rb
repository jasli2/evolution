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

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |position|
        csv << position.attributes.values_at(*column_names)
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
    (2..spreadsheet.last_row).each do |i|
      row = spreadsheet.row(i);

      position = find_by_name(row[0]) || new
      position.name = row[0]
      position.description = row[1]
      position.standard = row[2]
      #save!(position)
      position.save!

      i = 3
      while i < length do
        competency = Competency.find_by_name(row[i])
        competency_level = competency.competency_levels.find_by_level(row[i.next])
        
        pcl = position.position_competency_levels.build(:position_id => position.id, :standard => row[i.next.next],\
                                                        :competency_level_id => competency_level.id)
        #save!(pcl)
        pcl.save!

        i += 3
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
