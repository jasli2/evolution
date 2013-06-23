# encoding: utf-8
class CompetenciesController < ApplicationController

  #POST /competency/import
  def import
    error_info = Hash.new
    error_info =  Competency.import(params[:file])

    if error_info["error_num"] == 0
      redirect_to :back, notice: t("competency.all.notice1")
    else
      count = error_info["total"] - error_info["error_num"]
      info = "已成功导入#{count}条数据，#{error_info["error_num"]}条数据导入失败,请查看导入失败详细列表。"
      redirect_to :back, notice: info
    end
    rescue ActionController::RedirectBackError
      redirect_to root_path
  end

  def export
    @competencies = Competency.order('id DESC')
    if @competencies
      respond_to do |format|
        format.html {redirect_to competencies_path, notice: t("competency.all.notice2") }
        format.csv { send_data @competencies.to_csv, :type => "text/csv" }
        #format.xls
      end
    end
  end

  # GET /competency
  # GET /competency.json
  def index
    @menu_category = 'header'
    @menu_active = 'competency' 

    if params[:position_id]
      @position = Position.find(params[:position_id])
    else
      @competencies = Competency.order('id DESC')
    end

    respond_to do |format|
      format.html
    end
  end

end
