# == Schema Information
#
# Table name: activity_has_users
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  activity_id :integer
#  user_id     :integer
#

class ActivityHasUser < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :activity_id, :user_id

  validates :activity_id,  :presence => true
  validates :user_id,  :presence => true

  belongs_to :user
  belongs_to :activity
end
