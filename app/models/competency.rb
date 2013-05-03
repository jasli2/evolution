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
  attr_accessible :category, :description, :name

  validates :name, :presence => true, :uniqueness => true
  validates :description, :presence => true

  has_many :competency_levels
end
