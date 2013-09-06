# == Schema Information
#
# Table name: notifications
#
#  id                :integer          not null, primary key
#  source_type       :string(255)
#  source_id         :integer
#  notification_type :string(255)
#  viewed_at         :datetime
#  user_id           :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Notification < ActiveRecord::Base
  attr_accessible :notification_type, :source_id, :source_type, :viewed_at, :user_id

  validates :user_id, :presence => true
  validates :notification_type, :presence => true

  belongs_to :user
  belongs_to :source, :polymorphic => true  
  attr_accessible :source

  scope :active, where(:viewed_at => nil)

  def set_viewed
    update_attributes(:viewed_at => Time.zone.now)
  end
end
