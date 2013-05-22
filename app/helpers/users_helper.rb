module UsersHelper
  def user_avatar_path(u, type)
    u.avatar_url(type) || "defaut_user_avatar_#{type}.png"
  end
end
