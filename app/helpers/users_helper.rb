module UsersHelper
  def user_avatar_path(u, type)
    u.avatar_url(type) || "defaut_user_avatar_#{type}.png"
  end

  def user_level(u)
    "Lv" + ( 2 + u.teacher_rate.to_i ).to_s
  end
end
