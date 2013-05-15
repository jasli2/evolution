class SiteController < ApplicationController
  def help
  end

  def about
  end

  def login
    @login_page = true
  end
end
