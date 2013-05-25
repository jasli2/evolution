class CompetenciesController < ApplicationController
  def index
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
    logger.info "herer............"
    @user = User.find(2)
    send_file "#{Rails.root}/app/assets/images/logo.png", :type => 'image/png'
    #redirect_to competencies_path, notice: "you just found export action......"
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

end
