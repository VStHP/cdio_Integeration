class CoursesController < ApplicationController
  before_action :logged_in_user
  def index
    unless current_user.suppervisor?
      @courses = current_user.courses
    else
      case params[:option]
      when "1"
        @courses = Course.owner current_user.id
      when "2"
        @courses = current_user.courses
      else
        @courses = Course.all
      end
    end
  end

  def show
  end

  def update
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new course_params
    if @course.save
      flash[:success] = t "controllers.courses.flash_success_create"
      redirect_to courses_path
    else
      render :new
    end
  end

  private

  def course_params
    params.require(:course).permit(:name, :description, :users_id, :organization,
      :program, :training_standard, :status)
  end
end
