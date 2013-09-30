class UserCourseRelationsController < ApplicationController
  def create
    course = Course.find(params[:user_course_relation][:leader_id])
    c_user = User.find_by_id(session[:user_id])
    c_user.follow_course!(course)
    redirect_to :back, :notice => t("users.all.notice8")

  end

  def destroy
    puts "**********"
    puts params
    puts "**********"

    course = UserCourseRelation.find(params[:id]).leader
    c_user = User.find_by_id(session[:user_id])
    c_user.unfollow_course!(course)
    redirect_to :back, :notice => t("users.all.notice9")
  end
end