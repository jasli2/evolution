class CoursesController < ApplicationController
  #POST /competency/import
  def import
    Course.import(params[:file])
    redirect_to :back, notice: t("course.all.notic4")
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
    @menu_category = 'user'
    @menu_active = params[:user_id] ? 'user_courses' : 'courses'

    @user = User.find(params[:user_id]) if params[:user_id]
    if @user
      @courses = Course.for_position(@user.position).page params[:page] unless @user.position.blank?
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

    respond_to do |format|
      format.html 
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
