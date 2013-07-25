# encoding: utf-8
class DiscussesController < ApplicationController
  def create
    @course_class = CourseClass.find(params[:class_id])

    @discuss = @course_class.discusses.build(params[:discuss])
    respond_to do |format|
      if @discuss.save
        format.html { redirect_to :back, :notice => "创建讨论成功。" }
      else
        format.html { redirect_to :back, :notice => "发布讨论失败。" }
      end
    end
  end
end
