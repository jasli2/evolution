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
    @competencies = Competency.all
  end

  def course
    @menu_category = 'admin'
    @menu_active = 'courses'
    @courses = Course.order(:id).page params[:page]
  end

  def position
    @menu_category = 'admin'
    @menu_active = 'positions'
    @positions = Position.all
  end
end
