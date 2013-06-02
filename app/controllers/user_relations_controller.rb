class UserRelationsController < ApplicationController
  def create
    @user = User.find(params[:user_relation][:leader_id])
    c_user = User.find_by_id(session[:user_id])
    c_user.follow!(@user)
    redirect_to :back, :notice => t("users.all.notice8")
  end

  def destroy
    @user = UserRelation.find(params[:id]).leader
    c_user = User.find_by_id(session[:user_id])
    c_user.unfollow!(@user)
    redirect_to :back, :notice => t("users.all.notice9")
  end
end
