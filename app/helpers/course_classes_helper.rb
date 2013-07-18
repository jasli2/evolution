module CourseClassesHelper
  def can_view_class_discussion?(c, u)
    u.admin? or c.teacher?(u) or c.assistent?(u) or c.student?(u)
  end

  def can_view_class_attachment?(c, u)
    u.admin? or c.teacher?(u) or c.assistent?(u) or c.student?(u)
  end

  def can_uploader_attachment?(c, u)   
    u.admin? or c.teacher?(u) or c.assistent?(u)
  end

  def can_post_discuss?(c, u)
    c.teacher?(u) or c.assistent?(u) or c.student?(u) 
  end
end
