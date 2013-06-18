# == Schema Information
#
# Table name: feed_items
#
#  id         :integer          not null, primary key
#  item_id    :integer
#  item_type  :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class FeedItem < ActiveRecord::Base
  attr_accessible :item

  belongs_to :item, :polymorphic =>true
  has_many :feeds, :dependent => :destroy

  def partial
	item.class.name.underscore
  end
end
