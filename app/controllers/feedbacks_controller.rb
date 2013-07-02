# encoding: utf-8

class FeedbacksController < ApplicationController
  def index
    @feedbacks = TrainingPlanFeedback.order('id DESC').all

    respond_to do |f|
      f.html
    end
  end

  def show
    @feedback = TrainingPlanFeedback.find(params[:id])

    respond_to do |f|
      f.html
    end
  end

  def new
    @tp = TrainingPlan.find(params[:training_plan_id])
    @feedback = TrainingPlanFeedback.new

    respond_to do |f|
      if @tp.users.include?(current_user)
        f.html
      else
        f.html { redirect_to current_user.admin? > admin_dashboard_path(current_user) : dashboard_user_path(current_user), :notice => "访问受限！" }
      end
    end
  end

  def edit
    @feedback = TrainingPlanFeedback.find(params[:id])

    respond_to do |f|
      f.html
    end
  end
end
