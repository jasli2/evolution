# encoding: utf-8
class CommentsController < ApplicationController
  
  def edit

  end

  def create
    @tp = Topic.find(params[:topic_id])
    @comment = @tp.comments.build
    @comment.content = params[:content]
    @comment.user_id = params[:user_id]

    @comment.repcomment_id = (params[:repcomment_id].nil?) ? 1073741823 : params[:repcomment_id]

    respond_to do |format|
      if @comment.save
        unless params[:repcomment_id]
          @tp.comments << @comment
        format.html { redirect_to topic_path(@tp), :notice => '已成功回复' }
        format.json { render json: @comment, status: :created, location: @comment }
      else

        format.html { redirect_to topic_path(@tp) }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update

  end

  def destroy

  end
end
