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

require 'spec_helper'

describe FeedItem do
  pending "add some examples to (or delete) #{__FILE__}"
end
