class PositionsController < ApplicationController

  def import
    Position.import(params[:file])
    redirect_to positions_path, notice: "Products imported."
  end

  # GET /competency
  # GET /competency.json
  def index
    @positions = Position.order(:id)
    if @positions
      respond_to do |format|
        format.html # index.html.erb
        format.csv { send_data @positions.to_csv }
        #format.xls
      end
    end
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
