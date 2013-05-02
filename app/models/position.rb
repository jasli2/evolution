class Position < ActiveRecord::Base
  attr_accessible :description, :name

  validates :name, :presence => true, :uniqueness => true

  has_many :position_competency_levels
  has_many :competency_levels, :through => :position_competency_levels
end
