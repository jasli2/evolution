# encoding: utf-8
class UsersController < ApplicationController
  before_filter :need_admin!, :only => [:new, :create]

  # for demo assessment process TODO: revisit it
  def mgr_assessments
    @menu_category = 'manager'
    @menu_active = 'assess'

    @user = User.find(params[:id])
  end

  def assessment
    @menu_category = 'manager'
    @menu_active = 'assess'

    @user = User.find(params[:id])
    session[:return_to] = request.referer
  end

  def update_assessment
    @user = User.find(params[:id])
    @user.is_assessed = true
    respond_to do |format|
      if @user.save
        format.html { redirect_to session.delete(:return_to), notice: t("users.all.notice1")}
      else
        format.html { redirect_to :back, notice: t("users.all.notice2")}
      end
    end
  end

  def dashboard
    @menu_category = 'user'
    @menu_active = 'home'
    
    @feed_items  = current_user.feed_items.page(params[:page]).per(5) unless current_user.feed_items.blank?
    @active_notifications = current_user.notifications.active
    @active_notifications.each do |n|
      n.update_attributes(:viewed_at => Time.zone.now)
    end
  end

  # GET /users
  # GET /users.json
  def index
    @users = User.order(:id)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @menu_category = current_user.admin? ? 'admin' : 'user'
    @menu_active = current_user.admin? ? 'users' : 'profile' 

    @user = User.find(params[:id])
    @pending_courses = Course.for_position(@user.position).page(params[:page]) unless @user.position.blank?
    @teach_courses = Course.for_teacher(@user).page(params[:page])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @menu_category = 'admin'
    @menu_active = 'users'
    @user = User.new
    session[:return_to] = request.referer

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    if current_user.admin?
      @menu_category = 'admin'
      @menu_active = 'users'
    else
      @menu_category = 'user'
      @menu_active = 'profile'
    end
    @user = User.find(params[:id])
    session[:return_to] = request.referer
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to session.delete(:return_to), notice: t("users.all.notice3") }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to session.delete(:return_to), notice:t("users.all.notice4") }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to :back, :notice =>t("users.all.notice5")}
      format.json { head :no_content }
    end
  end

  #POST /users/import
  def import
    error_info = Hash.new
    error_info =  User.import(params[:file])
    if error_info["error_num"] == 0
      redirect_to :back, notice: t("users.all.notice6")
    else
      count = error_info["total"] - error_info["error_num"]
      info = "已成功导入#{count}条数据，#{error_info["error_num"]}条数据导入失败,请查看导入失败详细列表。"
      redirect_to :back, notice: info
    end
    rescue ActionController::RedirectBackError
      redirect_to root_path
    
  end

  def export
    @users = User.order(:staff_id)
    respond_to do |format|
      format.html {redirect_to :back, notice: t("users.all.notice7") }
      format.csv { send_data @users.to_csv, :type => "text/csv" }
    end
  end
end
