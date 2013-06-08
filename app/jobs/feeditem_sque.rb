class FeeditemSque
  @queue = "feed_item"

  def self.perform(feed_item_id)
	feed_item = FeedItem.find(feed_item_id)
	feed_item.gen_feed_item
  end 	
end