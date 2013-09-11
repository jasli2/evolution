# encoding: utf-8
class CommentsController < ApplicationController
  
  def edit

  end

  def create
    @comment = Comment.new(params[:comment])
    @comment.repcomment_id = (params[:comment][:repcomment_id].nil?) ? nil : params[:comment][:repcomment_id]

    respond_to do |format|
      if @comment.save
        format.html { redirect_to :back, :notice => '已成功回复' }
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { redirect_to :back }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update

  end

  def destroy

  end
end
