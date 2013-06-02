class PositionsController < ApplicationController

  def import
    Position.import(params[:file])
    redirect_to :back, notice: t("position.all.notice1")
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
