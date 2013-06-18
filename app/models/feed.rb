# == Schema Information
#
# Table name: feeds
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  feed_item_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Feed < ActiveRecord::Base
	belongs_to :user
	belongs_to :feed_item
end
