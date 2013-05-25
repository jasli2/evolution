class Admin::AdminController < ApplicationController
  before_filter :need_admin!

  def dashboard
    @menu_category = 'admin'
    @menu_active = 'dashboard'
    @users = User.staff
    @competencies = Competency.all
    @courses = Course.all
    @positions = Position.all

    respond_to do |format|
      format.html
    end
  end

  def user
    @menu_category = 'admin'
    @menu_active = 'users'
    @users = User.staff

    respond_to do |format|
      format.html
    end
  end

  def competency
    @menu_category = 'admin'
    @menu_active = 'competency'
  end

  def course
    @menu_category = 'admin'
    @menu_active = 'courses'
  end

  def position
    @menu_category = 'admin'
    @menu_active = 'positions'
  end
end
