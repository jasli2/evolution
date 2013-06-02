#encoding: utf-8
class QuestionsController < ApplicationController
  before_filter :need_admin!

  def new
    logger.debug "p:::: " + params.to_s
    @exam = Examination.find(params[:examination_id])
    @question = Question.new
    session[:return_to] = request.referer

    respond_to do |format|
      format.html
      format.json { render json: @question }
    end
  end

  def create
    @exam = Examination.find(params[:examination_id])
    @question = @exam.questions.build(params[:question])
 
    respond_to do |format|
      if @question.save
        format.html { redirect_to session.delete(:return_to), notice: '添加考题成功！'}
      else
        format.html { render 'new' }
      end
    end
  end

  def edit
    @exam = Examination.find(params[:examination_id])
    @question = Question.find(params[:id])
    session[:return_to] = request.referer

    respond_to do |format|
      format.html 
      format.json { render json: @question }
    end
  end

  def update
    @question = Question.find(params[:id])

    respond_to do |format|
      if @question.update_attributes(params[:question])
        format.html { redirect_to session.delete(:return_to), notice: '更新考试信息成功！'}
      else
        format.html { render 'edit' }
      end
    end    
  end

  def destroy
    logger.debug "destroy: id = " + params[:id].to_s
    @question = Question.find(params[:id])
    @question.destroy

    respond_to do |format|
      format.html { redirect_to :back, :notice => "删除试题成功！" }
    end
  end
end
