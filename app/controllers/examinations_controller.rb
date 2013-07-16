#encoding: utf-8
class ExaminationsController < ApplicationController
  before_filter :need_admin!, :only => [:new, :edit, :create, :update, :destroy]

  def index
    if current_user.admin?
      @menu_category = 'admin'
      @menu_active = 'exam'
    else
      @menu_category = 'header'
      @menu_active = 'exam'
    end
    session[:return_to] = request.referer

    @exams = Examination.order(:id)

    respond_to do |format|
      format.html
    end
  end

  def show
    @menu_category = 'admin'
    @menu_active = 'exam'
    @exam = Examination.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def new
    @menu_category = 'admin'
    @menu_active = 'exam'
    @exam = Examination.new
    session[:return_to] = request.referer

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @exam }
    end
  end

  def create
    @exam = Examination.new(params[:examination])

    respond_to do |format|
      if @exam.save
        format.html { redirect_to session.delete(:return_to), notice: '创建考试成功！'}
      else
        format.html { render 'new' }
      end
    end
  end

  def edit
    @menu_category = 'admin'
    @menu_active = 'exam'
    @exam = Examination.find(params[:id])
    session[:return_to] = request.referer

    respond_to do |format|
      format.html 
      format.json { render json: @exam }
    end
  end

  def update
    @exam = Examination.find(params[:id])

    respond_to do |format|
      if @exam.update_attributes(params[:examination])
        format.html { redirect_to session.delete(:return_to), notice: '更新考试信息成功！'}
      else
        format.html { render 'edit' }
      end
    end
  end

  def confirm_publish

    @exam = Examination.find(params[:id]) if current_user.admin?
    respond_to do |format|
      if @exam.confirm_publish
        format.html { redirect_to :back, :notice => "在线考试：, 发布成功！"}
      else
        format.html { render 'index' }
      end
    end
  end

  def destroy
    
  end
end
