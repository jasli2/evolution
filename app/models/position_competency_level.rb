# == Schema Information
#
# Table name: position_competency_levels
#
#  id                  :integer          not null, primary key
#  standard            :integer
#  position_id         :integer
#  competency_level_id :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class PositionCompetencyLevel < ActiveRecord::Base
  attr_accessible :competency_level_id, :position_id, :standard

  validates :position_id, :presence => true
  validates :competency_level_id, :presence => true
  #validates :standard, :presence => true
  
  belongs_to :position
  belongs_to :competency_level
end
