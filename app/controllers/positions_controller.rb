class PositionsController < ApplicationController

  def import
    Position.import(params[:file])
    redirect_to positions_path, notice: "Products imported."
  end

  def export
    @positions = Position.order(:id)
    if @positions
      respond_to do |format|
        format.html {redirect_to positions_path, notice: "export open" }
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

  end

  def create

  end

  def update

  end
end
