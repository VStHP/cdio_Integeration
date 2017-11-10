class CoursesController < ApplicationController
  before_action :logged_in_user
  before_action :load_course, except: %i(new create index)

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

  def edit
    load_subjects @course
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
      redirect_back fallback_location: root_path
    else
      render :new
    end
  end

  def destroy
    if @course.init?
      if @course.destroy
        flash[:success] = "Delete #{@course.name} successful"
      else
        flash[:danger] = "Delete #{@course.name} unsuccessful"
      end
    else
      flash[:danger] = "#{@course.name} had been active, delete isn't allow"
    end
    redirect_back fallback_location: root_path
  end

  private

  def course_params
    params[:course][:date_start] = Date.strptime(params[:course][:date_start], "%m/%d/%Y")
    params.require(:course).permit(:name, :description, :users_id, :organization,
      :program, :training_standard, :date_start, :status)
  end

  def load_course
    @course = Course.find_by id: params[:id]
    return if @course
    flash[:danger] = t "controllers.courses.flash_danger"
    redirect_to :root
  end

  def load_subjects course
    @subjects = course.subjects
    @all_subjects = Subject.all
    @all_subjects = @all_subjects.without_course course if @subjects.present?
  end

  def load_trainers course
    @trainers = course.users.with_suppervisor.alphabet_name
    @all_trainers = User.with_suppervisor.alphabet_name
    @all_trainers = @all_trainers.without_course course if @trainers.present?
  end

  def load_trainees course
    @trainees = course.users.without_suppervisor.alphabet_name
    @all_trainees = User.without_suppervisor.alphabet_name
    @all_trainees = @all_trainees.without_course course if @trainees.present?
  end
end
