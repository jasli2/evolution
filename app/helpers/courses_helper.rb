module CoursesHelper
  def course_cover_path(c, type)
    c.cover_image_url(type) || "default_cover_#{type}.png"
  end
end
