module SessionsHelper

  def sign_in(user)
      session[:user_id] = user.id
      self.current_user = user
  end

  def login?
    session[:user_id]
  end

  def current_user_id
    session[:user_id]
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end
end
