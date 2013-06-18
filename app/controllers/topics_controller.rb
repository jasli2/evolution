class TopicsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @topics = @user.topics.all
  end

  def show
    @topic = Topic.find(params[:id])
    @comments = @topic.comments.all
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
