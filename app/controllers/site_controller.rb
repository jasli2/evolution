class SiteController < ApplicationController
  skip_before_filter :authenticate_user!

  def help
  end

  def about
  end

  def home
  end

  # demo static page
  def knowledge
    if current_user.admin?
      @menu_category = 'admin'
      @menu_active = 'knowledge'
    else
      @menu_category = 'header'
      @menu_active = 'knowledge'
    end
  end

  def datamining
    @menu_category = 'admin'
    @menu_active = 'datamining'
  end
end
