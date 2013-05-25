class CoursesController < ApplicationController
  #POST /competency/import
  def import
    Course.import(params[:file])
    redirect_to courses_path, notice: "Products imported."
  end

  def export
    @courses = Course.order(:id)
    if @courses
      respond_to do |format|
        format.html {redirect_to courses_path, notice: "export open" }
        format.csv { send_data @courses.to_csv }
        #format.xls
      end
    end
  end

  def index
    @courses = Course.order(:id)
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
