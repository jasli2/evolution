class CompetenciesController < ApplicationController
  #POST /competency/import
  def import
    Competency.import(params[:file])
    redirect_to competencies_path, notice: "Products imported."
  end

  # GET /competency
  # GET /competency.json
  def index
    @competencies = Competency.order(:name)
    if @competencies
      respond_to do |format|
        format.html # index.html.erb
        format.csv { send_data @competencies.to_csv }
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
