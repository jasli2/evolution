# == Schema Information
#
# Table name: papers
#
#  id           :integer          not null, primary key
#  score        :integer
#  correct_nums :integer
#  error_nums   :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Paper < ActiveRecord::Base
  attr_accessible :correct_nums, :error_nums, :score
  
  belongs_to :users
  belongs_to :examination
  has_many :user_answers

end
