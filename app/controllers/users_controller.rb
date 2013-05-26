class UsersController < ApplicationController
  before_filter :need_admin!, :only => [:new, :create]

  def dashboard
    @menu_category = 'user'
    @menu_active = 'home' 
    @pending_courses = current_user.get_position_courses(3)
  end

  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    puts @user.email
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
    session[:return_to] ||= request.referer

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
      @menu_active = 'dashboard'
    end
    @user = User.find(params[:id])
    session[:return_to] ||= request.referer
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to session.delete(:return_to), notice: 'User was successfully created.' }
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
        format.html { redirect_to session.delete(:return_to), notice: 'User was successfully updated.' }
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
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  #POST /users/import
  def import
    User.import(params[:file])
    redirect_to :back, notice: "Users has successfully imported."
    rescue ActionController::RedirectBackError
      redirect_to root_path
    
  end

  def export
    @users = User.order(:staff_id)
    puts "*************************"
    respond_to do |format|
      format.html {redirect_to users_path, notice: "export open" }
      format.csv { send_data @users.to_csv, :type => "text/csv" }
    end
  end
end