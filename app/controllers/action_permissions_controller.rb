#encoding: utf-8
class ActionPermissionsController < ApplicationController

  def new
    @menu_category = 'admin'
    @menu_active = 'permission'

    @model_permission_id = params[:index]
    @authority = ActionPermission.new
    session[:return_to] = request.referer

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @authority }
    end
  end

  def create    
   @model = ModelPermission.find(params[:action_permission][:model_permission_id])
   @authority = @model.action_permissions.build(params[:action_permission])
     
    respond_to do |format|  
      @record = ActionPermission.find_by_model_permission_id_and_action_name(@authority.model_permission_id, @authority.action_name) 
      if @record   	  
          format.html { render 'edit' }
      else    
        if @authority.save
          session.delete(:return_to)
          format.html { redirect_to :controller => 'permissions', :action => "index"}
        else
          format.html { render 'new' }
        end
      end
    end
  end

  def edit
    @menu_category = 'admin'
    @menu_active = 'permission'

    @authority = ActionPermission.find_by_model_permission_id(params[:id])
    session[:return_to] = request.referer

    respond_to do |format|
      format.html 
      format.json { render json: @authority }
    end
  end

  def update  	
  	@authority = ActionPermission.find_by_model_permission_id_and_action_name(params[:id], 
  		params[:action_permission][:action_name])

    respond_to do |format|
      if @authority.update_attributes(params[:action_permission])
        format.html { redirect_to session.delete(:return_to), notice: '更新权限信息成功！'}
      else
        format.html { render 'edit' }
      end
    end
  end

  def destroy
    
  end

end
