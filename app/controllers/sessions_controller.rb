class SessionsController < ApplicationController
  skip_before_filter :authenticate_user!, :only => [:new, :create]
  layout :set_layout

  def new
  end

  def create
    user = User.auth(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to user.admin? ? admin_dashboard_path : dashboard_user_path(user), :notice => "Logged in!"
    else
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end

  private

  def set_layout
    action_name == 'new' ? 'login' : 'application'
  end
end
