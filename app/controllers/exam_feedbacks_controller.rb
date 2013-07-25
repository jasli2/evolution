#encoding: utf-8
class ExamFeedbacksController < ApplicationController
  def new
    #TODO:fix if user has access exam 
    @exam = Examination.find(params[:examination_id])
    @exam_feedback = ExaminationFeedback.new
    respond_to do |f|
      f.html
    end
  end

  def edit

  end

  def show
    @exam = Examination.find(params[:examination_id])
    @exam_feedback = ExaminationFeedback.find(params[:id])
    @paper = @exam.check_user_paper(@exam_feedback.user_id)

  end

  def create
    @exam = Examination.find(params[:examination_id])
    @paper = @exam.check_user_paper(current_user.id)
    @exam_feedback = @exam.feedbacks.create!(:user_id => current_user.id)
    respond_to do |format|
      if @exam_feedback
        Resque.enqueue(ExaminationSque, @exam.id, @paper.id, @exam_feedback.id, params[:answer])
        format.html { redirect_to examinations_path, :notice => "考试结束！"}
      else
        format.html { redirect_to examinations_path, :notice => "考试系统出错！"}
      end
    end
  end

end
