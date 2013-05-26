class CoursesController < ApplicationController
  #POST /competency/import
  def import
    Course.import(params[:file])
    redirect_to :back, notice: "Courses has successfully imported."
    rescue ActionController::RedirectBackError
      redirect_to root_path
  end

  def export
    @courses = Course.order(:id)
    if @courses
      respond_to do |format|
        format.html {redirect_to courses_path, notice: "export open" }
        format.csv { send_data @courses.to_csv }
        #format.xls
      end
    end
  end

  def index
    @courses = Course.order(:id).page params[:page]
  end

  def show
  end

  def new
    @menu_category = current_user.admin? ? 'admin' : 'user'
    @menu_active = current_user.admin? ? 'courses' : 'user_courses'
    @course = Course.new
    session[:return_to] ||= request.referer

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
    session[:return_to] ||= request.referer
  end

  def create
    @course = Course.new(params[:course])

    respond_to do |format|
      if @course.save
        format.html { redirect_to session.delete(:return_to), notice: 'Course was successfully created.' }
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
      if @course.update_attributes(params[:Course])
        format.html { redirect_to session.delete(:return_to), notice: 'Course was successfully updated.' }
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
