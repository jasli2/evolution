class ClassCourseSque
  @queue = 'course_class'

  def self.perform(course_class_id)
    course_class = CourseClass.find(course_class_id)
    puts "******course_class******"
    puts course_class.id
    puts "****course_class********"
    course_class.gen_feed_item
  end
end