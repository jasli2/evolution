class CompetenciesController < ApplicationController
  #POST /competency/import
  def import
    Competency.import(params[:file])
    
    redirect_to :back, notice: "Competencies has successfully imported."
    rescue ActionController::RedirectBackError
      redirect_to root_path
  end

  def export
    @competencies = Competency.order('id DESC')
    if @competencies
      respond_to do |format|
        format.html {redirect_to competencies_path, notice: "export open" }
        format.csv { send_data @competencies.to_csv, :type => "text/csv" }
        #format.xls
      end
    end
  end

  # GET /competency
  # GET /competency.json
  def index
    @menu_category = 'user'
    @menu_active = 'competency' 

    if params[:position_id]
      @position = Position.find(params[:position_id])
    else
      @competencies = Competency.order('id DESC')
    end

    logger.info "position_id: " + params[:position_id].to_s
    respond_to do |format|
      format.html
    end
  end

end
