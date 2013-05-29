class UserRelationsController < ApplicationController
  def create
    @user = User.find(params[:user_relation][:leader_id])
    c_user = User.find_by_id(session[:user_id])
    c_user.follow!(@user)
    redirect_to :back, :notice => "Add followed user success!"
  end

  def destroy
    @user = UserRelation.find(params[:id]).leader
    c_user = User.find_by_id(session[:user_id])
    c_user.unfollow!(@user)
    redirect_to :back, :notice => "unfollowing user success!"
  end
end
