class TopicsController < ApplicationController
  def index
    @user = User.find(params[:user_id]) if params[:user_id]
    @topics = Topic.order('id DESC').page params[:page]
=begin
    if @user
      @topics = @user.topics.all
    else
      @topics = Topic.order('id DESC').page params[:page]
    end
=end

  end

  def show
    @topic = Topic.find(params[:id])
    @comments = @topic.comments.all
    @reply = Comment.new
  end

  def new
    @topic = Topic.new
  end

  def create
    @user = User.find(params[:user_id])
    @topic = @user.topics.build(params[:topic])
    
    respond_to do |format|
      if @topic.save
        format.html {redirect_to :action => "index"}
      else
        format.html {render "new"}
      end
    end
  end

  def update

  end

  def destroy

  end
end
