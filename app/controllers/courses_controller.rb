# encoding: utf-8
class CoursesController < ApplicationController
  #POST /competency/import
  def import
    error_info = Hash.new
    error_info = Course.import(params[:file])
    if error_info["error_num"] == 0
      redirect_to :back, notice: t("course.all.notic4")
    else
      count = error_info["total"] - error_info["error_num"]
      info = "已成功导入#{count}条数据，#{error_info["error_num"]}条数据导入失败,请查看导入失败详细列表。"
      redirect_to :back, notice: info
    end
    rescue ActionController::RedirectBackError
      redirect_to root_path
  end

  def export
    @courses = Course.order('id DESC')
    if @courses
      respond_to do |format|
        format.html {redirect_to courses_path, notice: t("course.all.notic5") }
        format.csv { send_data @courses.to_csv }
        #format.xls
      end
    end
  end

  def index
    @menu_category =  params[:user_id] ? 'user' : 'header'
    @menu_active = params[:user_id] ? 'user_courses' : 'course'

    @user = User.find(params[:user_id]) if params[:user_id]
    if @user
      if params[:teacher_id]
        @courses = Course.for_teacher(User.find(params[:teacher_id])) unless params[:teacher_id].blank?
        @courses = @courses.for_position(@user.position).page params[:page] unless @user.position.blank?
      else
        @courses = Course.for_position(@user.position).page params[:page] unless @user.position.blank?
      end
    else
      if params[:teacher_id] or params[:position_id]
        @courses = Course.for_teacher(User.find(params[:teacher_id])) unless params[:teacher_id].blank?
        @courses = @courses.for_position(Position.find(params[:position_id])) unless params[:position_id].blank?
        @courses = @courses.page params[:page]
      else
        @courses = Course.order('id DESC').page params[:page]
      end
    end
  end

  def show
    @menu_category = current_user.admin? ? 'admin' : 'user'
    @menu_active = current_user.admin? ? 'courses' : 'user_courses'
    @course = Course.find(params[:id])
    @course_class = @course.find_class_for_user(current_user)

    respond_to do |format|
      if @course_class
        format.html { redirect_to class_path(@course_class) }
      else
        format.html
      end

      format.json { render json: @course }
    end
  end

  def new
    @menu_category = current_user.admin? ? 'admin' : 'user'
    @menu_active = current_user.admin? ? 'courses' : 'user_courses'
    @course = Course.new
    session[:return_to] = request.referer

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @course }
    end
  end

  def edit
    if current_user.admin?
      @menu_category = 'admin'
      @menu_active = 'courses'
    else
      @menu_category = 'user'
      @menu_active = 'user_courses'
    end
    @course = Course.find(params[:id])
    session[:return_to] = request.referer
  end

  def create
    @user = User.find(params[:user_id]) if params[:user_id]
    @course = @user.create_courses.build(params[:course])

    respond_to do |format|
      if @course.save
        format.html { redirect_to session.delete(:return_to), notice: t("course.all.notic6") }
        format.json { render json: @course, status: :created, location: @course }
      else
        format.html { render 'new' }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @course = Course.find(params[:id])

    respond_to do |format|
      if @course.update_attributes(params[:course])
        format.html { redirect_to session.delete(:return_to), notice: t("course.all.notic7") }
        format.json { render json: @course, status: :updated, location: @course }
      else
        format.html { render action: "edit" }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
  end
end
