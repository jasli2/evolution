class SessionsController < ApplicationController
  def new

  end
  def create
    user = User.find_by_email(params[:session][:email].downcase)

    if user && user.authenticate(params[:session][:password])

      puts "auth ok"
      session[:user_id] = user.id
      redirect_to user_path(user), :notice => "Logged in!"
    else
      puts "auth failed"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end
end
