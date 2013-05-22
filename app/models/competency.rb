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
  attr_accessible :category_id, :description, :name

  validates :name, :presence => true, :uniqueness => true
  validates :description, :presence => true

  has_many :competency_levels
  has_many :competency_users
  has_many :users, :through => :competency_users

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      #column_names.delete("password_digest")
      csv << column_names
      all.each do |competency|
        #puts *column_names
        csv << competency.attributes.values_at(*column_names)
      end
    end
  end

=begin
    competency Tab contains :
    competency : name,description
    competency_level: level level_description(description)
    competency_level_requirement(4):level_requirement(description) weight

row[0]  row[1]      row[2]  row[3]            row[4]            row[5]
name   description  level  level_description  level_requirement Weight
=end


  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    competency = Competency.new
    (2..spreadsheet.last_row).each do |i|

      row = spreadsheet.row(i);
      length = row.length
      if (row[0].nil? || row[0].empty?)
        #fix me
      else
        competency = find_by_name(row[0]) || new
        competency.name = row[0]
        competency.description = row[1]
        competency.save
      end
      competency_level = competency.competency_levels.build(:level => row[2], :description => row[3])
      competency_level.save
      puts "----------------------"
      puts row[2]
      puts row[3]
      puts  competency.name
      puts competency.competency_levels.size
      puts "----------------------"

      ptr = 4
      while ptr < length  do
        competency_level_requirement =  competency_level.competency_level_requirements.build(:description => row[ptr], :weight => row[ptr.next])
        competency_level_requirement.save
        ptr += 2;
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
