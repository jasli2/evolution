class CompetencyLevel < ActiveRecord::Base
  attr_accessible :competency_id, :description, :level

  validates :level, :presence => true, :uniqueness => true
  validates :description, :presence => true

  belongs_to :competency
  has_many :competency_level_requirements
end
