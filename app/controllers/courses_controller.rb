class CoursesController < ApplicationController
  #POST /competency/import
  def import
    Course.import(params[:file])
    redirect_to courses_path, notice: "Products imported."
  end

  def index
    @courses = Course.order(:id)
    if @courses
      respond_to do |format|
        format.html # index.html.erb
        format.csv { send_data @courses.to_csv }
        #format.xls
      end
    end
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
end
