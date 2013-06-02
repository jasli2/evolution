module CoursesHelper
  def course_cover_path(c, type)
    c.cover_image_url(type) || "default_cover_#{type}.png"
  end

  def teacher_rate_tag(u)
    i = u.teacher_rate.blank? ? 0 : u.teacher_rate.to_i
    str = "<i class='iconfa-star'></i>" * i
    str = str + "<i class='iconfa-star-empty'></i>" * (5-i)
    str = "<span class='teacher-rate'>" + str + "</span>"
    str.html_safe
  end
end
