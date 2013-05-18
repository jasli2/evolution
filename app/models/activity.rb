# == Schema Information
#
# Table name: activities
#
#  id          :integer          not null, primary key
#  description :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Activity < ActiveRecord::Base
  attr_accessible :description

  has_many :activity_has_user
  has_many :activity_has_course
end
