#encoding: utf-8
class PermissionsController < ApplicationController
  def index
    @menu_category = 'admin'
    @menu_active = 'permission'

    if params[:user_id]
      @user = User.find(params[:user_id])
      if @user.admin?
        @authority = DefaultPermission.where("role =?", "Admin")
      else
        if @user.position_id == 4
          @authority = DefaultPermission.where("role =?", "Manager")   
        else
          @authority = DefaultPermission.where("role =?", "Staff")
        end  
      end  
      respond_to do |format|
        format.html { render 'show' }
      end
    else  
      if params[:model_name] == nil && params[:role] == nil
        @authority = DefaultPermission.order(:model_name)
      else
        if params[:model_name] != "nil" && params[:role] != "nil"
          @authority = DefaultPermission.where("model_name =? AND role =?", params[:model_name], params[:role])
        else
          if (params[:role] == "nil" && params[:model_name] == "nil")
            @authority = DefaultPermission.order(:model_name)
          else
            if params[:role] == "nil"  
              @authority = DefaultPermission.where("model_name =?", params[:model_name])
            else
              if params[:model_name] == "nil"
                @authority = DefaultPermission.where("role =?", params[:role])
              end
            end
          end           
        end    
      end 
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
      if @user.admin?
        @authority = DefaultPermission.where("role =?", "Admin")
      else
        if @user.position_id == 4
          @authority = DefaultPermission.where("role =?", "Manager")   
        else
          @authority = DefaultPermission.where("role =?", "Staff")
        end  
      end  
    end  
    respond_to do |format|
      format.html
    end
  end

  def new
    @menu_category = 'admin'
    @menu_active = 'permission'

    @authority = DefaultPermission.new
    session[:return_to] = request.referer

    @scope_list = {
      I18n.t("permission scope null") => 0,
      I18n.t("permission scope self") => 1,
      I18n.t("permission scope department") => 2,
      I18n.t("permission scope global") => 3
    }

    @role_list = {
      I18n.t("permission role admin") => "Admin",
      I18n.t("permission role manager") => "Manager",
      I18n.t("permission role teacher") => "Teacher",
      I18n.t("permission role staff") => "Staff"
    }

    @model_list = {
      I18n.t("permission model user") => "User",
      I18n.t("permission model permission") => "Permission",
      I18n.t("permission model ability") => "Ability",
      I18n.t("permission model teacher") => "Teacher",
      I18n.t("permission model course") => "Course",
      I18n.t("permission model plan") => "Plan",
      I18n.t("permission model knowledge") => "Knowledge",
    }

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @authority }
    end
  end

  def create    
    @authority = DefaultPermission.new(params[:default_permission])

    respond_to do |format|
      if @authority.save
        format.html { redirect_to session.delete(:return_to), notice: '创建权限成功！'}
      else
        format.html { render 'new' }
      end
    end
  end

  def edit
    @authority = DefaultPermission.find(params[:id])
    @scope_list = {
      I18n.t("permission scope null") => 0,
      I18n.t("permission scope self") => 1,
      I18n.t("permission scope department") => 2,
      I18n.t("permission scope global") => 3
    }
    session[:return_to] = request.referer
  end

  def update
    @authority = DefaultPermission.find(params[:id])

    respond_to do |format|
      if @authority.update_attributes(params[:default_permission])
        format.html { redirect_to session.delete(:return_to), notice: '更新权限信息成功！'}
      else
        format.html { render 'edit' }
      end
    end
  end

  def destroy
    
  end

end
