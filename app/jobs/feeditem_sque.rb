class FeedItemSque
  @queue = "feed_item"

  def self.perform(relation_id)
	user_relation = UserRelation.find(relation_id)
	user_relation.gen_feed_item
  end 	
end
