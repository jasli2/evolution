#encoding: utf-8
class QuestionsController < ApplicationController
  before_filter :need_admin!

  def new
    @exam = Examination.find(params[:examination_id])
    @question = Question.new
    @question_type = params[:question_type] if params[:question_type]

    session[:return_to] = request.referer
    respond_to do |format|
      format.html
      format.json { render json: @question }
    end
  end

  def new_option
    @exam = Examination.find(params[:examination_id])
    @question = Question.new
    @question_type = params[:question][:question_type_str]
    respond_to do |format|
      format.html { redirect_to :action => 'new', :question_type => params[:question][:question_type_str], :examination_id => @exam.id  }
      format.json { render json: @question }
    end
  end

  def create
    @exam = Examination.find(params[:examination_id]) 
    @question = @exam.questions.build(params[:question])
    @question.question_type_str=params[:type]

    respond_to do |format|
      if @question.save!
        @question.check_question_options(params[:options]) if params[:options]
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
    @question_type = @question.question_type_str

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
