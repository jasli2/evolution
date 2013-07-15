# encoding: utf-8

class CourseClassesController < ApplicationController
  def eroll
    @course_class = CourseClass.find(params[:id])
    @user = User.find(params[:course_class][:user_id])

    respond_to do |format|
      if @course_class.eroll(@user)
        format.html { redirect_to class_path(@course_class), :notice => "报名成功。" }
      else
        format.html { redirect_to :back, :notice => "报名失败。" }
      end
    end
  end

  def uneroll
    @course_class = CourseClass.find(params[:id])
    @user = User.find(params[:course_class][:user_id])

    respond_to do |format|
      if @course_class.uneroll(@user)
        format.html { redirect_to course_path(@course_class.course), :notice => "退出班级成功。" }
      else
        format.html { redirect_to :back, :notice => "退出班级失败。" }
      end
    end
  end  

  def index
    @course_classes = CourseClass.all

    respond_to do |format|
      format.html
    end
  end

  def show
    @course_class = CourseClass.find(params[:id])
    @course = @course_class.course
    @course_class.attachments.build

    respond_to do |format|
      format.html
    end
  end

  def edit
    @course_class = CourseClass.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def new
    @course = Course.find(params[:course_id])
    @course_class = CourseClass.new

    session[:return_to] = request.referer

    respond_to do |format|
      format.html
    end
  end

  def create
    @course_class = CourseClass.new(params[:course_class])
    @course = Course.find(params[:course_class][:course_id])

    respond_to do |format|
      if @course_class.save
        format.html { redirect_to session.delete(:return_to), :notice => "班级创建成功。" }
      else
        format.html { render 'new' }
      end
    end
  end

  def update
    @course_class = CourseClass.find(params[:id])
    @course = @course_class.course

    respond_to do |format|
      if @course_class.update_attributes(params[:course_class])
        if session.delete(:return_to)
          format.html { redirect_to session.delete(:return_to), :notice => "更新班级信息成功。"}
        else
          format.html { redirect_to class_path(@course_class), :notice => "更新班级信息成功。"}
        end
      else
        format.html { render 'edit' }
      end
    end
  end

  def destroy
    
  end

end
