class Admin::AdminController < ApplicationController
  before_filter :need_admin!

  def dashboard
    @menu_category = 'admin'
    @menu_active = 'dashboard'
    @users = User.staff.last(4).reverse
    @users_count = User.staff.size
    @competencies = Competency.last(4).reverse
    @competencies_count = Competency.all.size
    @courses = Course.last(4).reverse
    @courses_count = Course.all.size
    @positions = Position.last(4).reverse
    @positions_count = Position.all.size

    respond_to do |format|
      format.html
    end
  end

  def user
    @menu_category = 'admin'
    @menu_active = 'users'
    @users = User.staff.page params[:page]

    respond_to do |format|
      format.html
    end
  end

  def competency
    @menu_category = 'admin'
    @menu_active = 'competency'
    if params[:position_id]
      @position = Position.find(params[:position_id])
    else
      @competencies = Competency.order(:name)
    end
  end

  def course
    @menu_category = 'admin'
    @menu_active = 'courses'

    if params[:teacher_id] or params[:position_id]
        @courses = Course.for_teacher(User.find(params[:teacher_id])) unless params[:teacher_id].blank?
        @courses = @courses.for_position(Position.find(params[:position_id])) unless params[:position_id].blank?
        @courses = @courses.page params[:page]
    else
        @courses = Course.order('id DESC').page params[:page]
    end

  end

  def position
    @menu_category = 'admin'
    @menu_active = 'positions'
    @positions = Position.all
  end
end
