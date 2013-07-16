#encoding: utf-8
class QuestionsController < ApplicationController
  before_filter :need_admin!

  def new
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
      if @question.save!
        @exam.examination_questions.create(:question_id => @question.id)
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
    if params[:examination_id]
      @exam = Examination.find(params[:examination_id])
      examination_question =  @exam.examination_questions.find_by_question_id(params[:id])
      examination_question.destroy
    else
      @question = Question.find(params[:id])
      @question.destroy
    end

    respond_to do |format|
      format.html { redirect_to :back, :notice => "删除试题成功！" }
    end
  end
end
