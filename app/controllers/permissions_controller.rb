#encoding: utf-8
class PermissionsController < ApplicationController
  filter_access_to :all
  def index
    @menu_category = 'admin'
    @menu_active = 'permission'

    if params[:id]
      respond_to do |format|
        format.html { render 'show' }
      end  
    else 
      @users = User.staff.order('id DESC').page params[:page]

      respond_to do |format|
        format.html
      end   
    end
  end

  def show
    @menu_category = 'admin'
    @menu_active = 'permission'

    if params[:id]
      @user = User.find(params[:id])
      authority = PermissionRole.where("user_id =?", @user.id) 
      @permit = Hash.new
      module_list = ["user","competency","course","plan","permission","examination", "knowledge", "report"]
      module_list.each do |n|
        @permit[n] = "user"
        if n = "plan" || n = "report"
          @permit[n] = "guest"
        end
      end
      if authority.size != 0 
        authority.each do |a|
          @permit[a.module_name] = a.role
        end
      end
      respond_to do |format|
        format.html
      end
    end
  end

  def new

  end

  def create    

  end

  def edit
    if params[:module] == "user" || params[:module] == "permission"
      @scope_list = [
        "guest",
        "user",
        "manage",
        "admin"
      ]
    end
    if params[:module] == "competency"
      @scope_list = [
        "guest",
        "user",
        "manage",
        "senior_manager",
        "admin"
      ]
    end
    if params[:module] == "course"
      @scope_list = [
        "guest",
        "user",
        "manage",
        "teacher",
        "admin"
      ]
    end
    if params[:module] == "plan" || params[:module] == "report"
      @scope_list = [
        "guest",
        "admin"
      ]
    end
    if params[:module] == "examination"
      @scope_list = [
        "guest",
        "user",
        "teacher",
        "admin"
      ]
    end
    if params[:module] == "knowledge"
      @scope_list = [
        "guest",
        "user",
        "admin"
      ]
    end
    @authority = PermissionRole.where(:id => params[:id], :module_name => params[:module])
    if @authority.size == 0
      @authority = PermissionRole.new
      @authority.user_id = params[:id]
      @authority.module_name = params[:module]
      @authority.role = params[:role]
    end
    session[:return_to] = request.referer
  end

  def update
    @authority = PermissionRole.where(:user_id => params[:permission_role][:user_id], :module_name => params[:permission_role][:module_name])
    respond_to do |format|
      if @authority.size == 0
        @authority = PermissionRole.new(params[:permission_role])
        if @authority.save
          format.html { redirect_to session.delete(:return_to), notice: '更新权限信息成功！'}
        else
          format.html { render 'edit' }
        end
      else
        if @authority.update_attributes(params[:permission_role])
          format.html { redirect_to session.delete(:return_to), notice: '更新权限信息成功！'}
        else
          format.html { render 'edit' }
        end
      end
    end
  end

  def destroy
    
  end

end
