class SiteController < ApplicationController
  skip_before_filter :authenticate_user!
  
  def help
  end

  def about
  end

  def home
  end
end
