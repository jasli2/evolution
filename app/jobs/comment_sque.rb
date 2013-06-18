class CommentSque
  @queue = "comment_sque"

  def self.perform(comment_id) 
    comment = Comment.find(comment_id)
    comment.gen_feed_item
  end
end
