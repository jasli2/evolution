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
  end

  def datamining
  end
end
