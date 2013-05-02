class CompetencyLevelRequirement < ActiveRecord::Base
  attr_accessible :competency_level_id, :description

  validates :description, :presence => true

  belongs_to :competency_level
end
