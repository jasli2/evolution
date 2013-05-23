class Admin::AdminController < ApplicationController
  before_filter :authenticate_user!
  
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
