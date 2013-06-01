class Examination < ActiveRecord::Base
  attr_accessible :creator_id, :title

  validates :creator_id, :presence => true
  validates :title, :presence => true

  has_many :questions
  belongs_to :creator , :class_name => "User"

end
