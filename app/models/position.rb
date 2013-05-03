# == Schema Information
#
# Table name: positions
#
#  id          :integer          not null, primary key
#  name        :string(40)
#  description :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Position < ActiveRecord::Base
  attr_accessible :description, :name

  validates :name, :presence => true, :uniqueness => true

  has_many :position_competency_levels
  has_many :competency_levels, :through => :position_competency_levels
  has_many :users
end
