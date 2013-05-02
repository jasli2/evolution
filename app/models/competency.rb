class Competency < ActiveRecord::Base
  attr_accessible :category, :description, :name

  validates :name, :presence => true, :uniqueness => true
  validates :description, :presence => true

  has_many :competency_levels
end
