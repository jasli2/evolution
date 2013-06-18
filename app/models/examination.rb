# == Schema Information
#
# Table name: examinations
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  creator_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Examination < ActiveRecord::Base
  attr_accessible :creator_id, :title

  validates :creator_id, :presence => true
  validates :title, :presence => true

  has_many :questions
  belongs_to :creator , :class_name => "User"

end
