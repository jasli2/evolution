class CompetenciesController < ApplicationController

  #POST /competency/import
  def import
    Competency.import(params[:file])
    
    redirect_to :back, notice: t("competency.all.notice1")
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
