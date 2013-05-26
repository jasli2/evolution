class CompetenciesController < ApplicationController
  def index
    @competencies = Competency.order(:name)
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end

  #POST /competency/import
  def import
    Competency.import(params[:file])

    redirect_to competencies_path, notice: "Products imported."
  end

  def export
    @competencies = Competency.order(:name)
    if @competencies
      respond_to do |format|
        format.html {redirect_to competencies_path, notice: "export open" }
        format.csv { send_data @competencies.to_csv, :type => "text/csv" }
        #format.xls
      end
    end
  end

end
