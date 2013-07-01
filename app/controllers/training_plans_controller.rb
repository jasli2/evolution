# encoding: utf-8

class TrainingPlansController < ApplicationController
  def index
    @tps = TrainingPlan.all
    respond_to do |format|
      format.html
    end
  end

  def new
    @tp = TrainingPlan.new
    session[:return_to] = request.referer

    respond_to do |format|
      format.html
    end
  end

  def show

  end

  def edit
  end

  def create
    logger.debug params
    @tp = TrainingPlan.new(params[:training_plan])

    respond_to do |format|
      if @tp.save
        format.html { redirect_to session.delete(:return_to), :notice => "培训计划：#{@tp.title}，已经创建成功！" }
      else
        format.html { render 'new' }
      end
    end
  end
end
