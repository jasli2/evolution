# encoding: utf-8
class PositionsController < ApplicationController

  def import
    error_info = Hash.new
    error_info =  Position.import(params[:file])

    if error_info["error_num"] == 0
      redirect_to :back, notice: t("position.all.notice1")
    else
      count = error_info["total"] - error_info["error_num"]
      info = "已成功导入#{count}条数据，#{error_info["error_num"]}条数据导入失败,请查看导入失败详细列表。"
      redirect_to :back, notice: info
    end
    rescue ActionController::RedirectBackError
      redirect_to root_path
  end

  def export
    @positions = Position.order(:id)
    if @positions
      respond_to do |format|
        format.html {redirect_to positions_path, notice: t("position.all.notice2") }
        format.csv { send_data @positions.to_csv }
        #format.xls
      end
    end
  end

  # GET /competency
  # GET /competency.json
  def index
    @positions = Position.order(:id)
  end

  def new

  end

  def show
    @position = Posistion.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render }
    end
  end

  def create

  end

  def update

  end
end
