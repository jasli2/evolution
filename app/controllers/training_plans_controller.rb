# encoding: utf-8

class TrainingPlansController < ApplicationController
  def index
    @menu_category = 'admin'
    @menu_active = 'plan'

    @tps = TrainingPlan.order("id DESC").all
    respond_to do |format|
      format.html
    end
  end

  def new
    @menu_category = 'admin'
    @menu_active = 'plan'

    @training_plan = TrainingPlan.new
    session[:return_to] = request.referer

    respond_to do |format|
      format.html
    end
  end

  def show
    @menu_category = 'admin'
    @menu_active = 'plan'

    @tp = TrainingPlan.find(params[:id])

    respond_to do |format|
      format.html { render @tp.state }
    end
  end

  def edit
    @menu_category = 'admin'
    @menu_active = 'plan'

    @training_plan = TrainingPlan.find(params[:id])
    session[:return_to] = request.referer

    respond_to do |format|
      format.html
    end
  end

  def create
    @tp = TrainingPlan.new(params[:training_plan])

    respond_to do |format|
      if @tp.save
        format.html { redirect_to session.delete(:return_to), :notice => "培训计划：#{@tp.title}，已经创建成功！" }
        format.json { render json: @tp, status: :created, location: @tp }
      else
        format.html { render 'new' }
        format.json { render json: @tp.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @tp = TrainingPlan.find(params[:id])

    respond_to do |format|
      if @tp.update_attributes(params[:training_plan])
        format.html { redirect_to session.delete(:return_to), :notice => "培训计划：#{@tp.title}，更新成功！" }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tp.errors, status: :unprocessable_entity }
      end
    end
  end

  # get publish
  def publish
    @menu_category = 'admin'
    @menu_active = 'plan'

    @tp = TrainingPlan.find(params[:id])
    session[:return_to] = request.referer

    respond_to do |format|
      format.html
    end    
  end

  # put confirm_publish
  def confirm_publish
    @tp = TrainingPlan.find(params[:id])

    respond_to do |format|
      if @tp.confirm_publish(params[:training_plan])
        format.html { redirect_to session.delete(:return_to), :notice => "培训计划：#{@tp.title}, 发布成功！"}
      else
        format.html { render 'publish' }
      end
    end
  end

end
