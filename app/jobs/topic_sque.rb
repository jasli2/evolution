class TopicSque
  @queue = "topic_sque"

  def self.perform(topic_id) 
    topic = Topic.find(topic_id)
    topic.gen_feed_item
  end

end
