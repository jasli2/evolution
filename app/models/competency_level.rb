# == Schema Information
#
# Table name: competency_levels
#
#  id            :integer          not null, primary key
#  level         :integer
#  description   :string(255)
#  competency_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class CompetencyLevel < ActiveRecord::Base
  attr_accessible :competency_id, :description, :level

  validates :level, :presence => true, :uniqueness => true
  validates :description, :presence => true

  belongs_to :competency
  has_many :competency_level_requirements

  has_many :position_competency_levels
  has_many :positions, :through => :position_competency_levels
end
