class Admin::AdminController < ApplicationController
  before_filter :need_admin!

  def dashboard
  end

  def user
  end

  def competency
  end

  def course
  end

  def position
  end
end
