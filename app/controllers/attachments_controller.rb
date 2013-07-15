# encoding: utf-8
class AttachmentsController < ApplicationController
  def create
    @attachment = Attachment.new(params[:attachment])
    
    respond_to do |format|
      if @attachment.save
        format.html { redirect_to :back, :notice => "上传附件成功。" }
      else
        format.html { redirect_to :back, :notice => "上传附件失败。" }
      end
    end
  end
end
