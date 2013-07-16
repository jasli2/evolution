#encoding: utf-8
class PermissionsController < ApplicationController
  def index
    @menu_category = 'admin'
    @menu_active = 'permission'

    @authority = ModelPermission.order(:id)

    respond_to do |format|
      format.html
    end
  end

  def show
    @menu_category = 'admin'
    @menu_active = 'permission'

    @authority = ModelPermission.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def new
    @menu_category = 'admin'
    @menu_active = 'permission'

    @authority = ModelPermission.new
    session[:return_to] = request.referer

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @authority }
    end
  end

  def create    
    @user = User.find(params[:model_permission][:user_id])    
    @authority = @user.model_permissions.build(params[:model_permission])
     
    respond_to do |format|  
      @record = ModelPermission.find_by_model_name_and_user_id(@authority.model_name, @authority.user_id)
      if @record
          format.html { redirect_to :controller => 'action_permissions', :action => "new", :index => @record.id }
      else    
        if @authority.save
          format.html { redirect_to :controller => 'action_permissions', :action => "new", :index => @authority.id }
          #format.html { redirect_to session.delete(:return_to), notice: '创建权限成功'}
        else
          format.html { render 'new' }
        end
      end
    end
  end

  def edit
    @menu_category = 'admin'
    @menu_active = 'permission'

    @authority = ModelPermission.find(params[:id])
    session[:return_to] = request.referer

    respond_to do |format|
      format.html { redirect_to :controller => 'action_permissions', :action => "edit" }
      #format.html 
      #format.json { render json: @authority }
    end
  end

  def update

  end

  def destroy
    
  end

end
