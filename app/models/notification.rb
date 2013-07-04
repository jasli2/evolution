class Notification < ActiveRecord::Base
  attr_accessible :notification_type, :source_id, :source_type, :viewed_at, :user_id

  belongs_to :user
  belongs_to :source, :polymorphic => true

  scope  
end
