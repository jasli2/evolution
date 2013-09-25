class UserCourseSque
  @queue = 'user_course_relation'

  def self.perform(relation_id) 
    course_relation = UserCourseRelation.find(relation_id)
    course_relation.gen_feed_item
  end

end
