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
    @tp = TrainingPlan.find(params[:training_plan_id]) if params[:training_plan_id]
    @feedback = TrainingPlanFeedback.new(:training_plan_id => @tp.id)
    session[:return_to] = request.referer

    respond_to do |f|
      if @tp.users.include?(current_user)
        f.html
      else
        f.html { redirect_to current_user.admin? ? admin_dashboard_path(current_user) : dashboard_user_path(current_user), :notice => "访问受限！" }
      end
    end
  end

  def edit
    @feedback = TrainingPlanFeedback.find(params[:id])

    respond_to do |f|
      f.html
    end
  end

  def create
    @tp = TrainingPlan.find(params[:training_plan_id])
    @feedback = @tp.feedbacks.build(params[:training_plan_feedback])

    respond_to do |format|
      if @feedback.save
        format.html { redirect_to session.delete(:return_to), :notice => "培训计划反馈提交成功！" }
      else
        format.html { render 'new' }
      end
    end
  end
end
