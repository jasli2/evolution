class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!

  helper_method :current_user
  helper_method :user_signed_in?
  helper_method :correct_user?

  helper :all
  protect_from_forgery 

  unless Rails.application.config.consider_all_requests_local
    rescue_from Exception, with: lambda { |exception| render_error 500, exception }
    rescue_from ActionController::RoutingError, ActionController::UnknownController, ::AbstractController::ActionNotFound, ActiveRecord::RecordNotFound, with: lambda { 
      |exception| render_error 404, exception 
    }
  end

  private
    def current_user
      begin
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
        @current_user
      rescue ActiveRecord::RecordNotFound
        nil
      end
    end

    def user_signed_in?
      return true if current_user
    end

    def correct_user?
      @user = User.find(params[:id])
      unless current_user == @user
        redirect_to root_url, alert: "Access denied."
      end
    end

    def not_found
      raise ActionController::RoutingError.new('Not Found')
    end

    def forbidden
      raise ActionController::RoutingError.new('Forbidden')
    end

    def render_error(status, exception)
      respond_to do |format|
        format.html { render :template => "errors/error_#{status}", :layout => 'error', :status => status }
        format.all { render :nothing => true, :status => status }
      end
    end

    def authenticate_user!
      if !current_user
        redirect_to root_url
      end
    end

    def need_admin!
      if !current_user.admin?
        forbidden
      end
    end
end
