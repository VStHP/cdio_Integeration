class CoursesController < ApplicationController
  before_action :verify_suppervisor_true
  before_action :logged_in_user, except: %i(index)
  before_action :load_course, except: %i(new create index )
  load_and_authorize_resource except: :create

  def index
    unless user_signed_in?
      redirect_to "/introduction"
    else
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
  end

  def show
    @subjects = @course.subjects
    @trainers = @course.users.trainers.alphabet_name
    @trainees = @course.users.trainees.alphabet_name
  end

  def edit; end

  def update
    if @course.update_attributes course_params
      flash[:success] = "Success! This course has been update successful"
      redirect_to @course
    else
      flash[:danger] =  "Oop! Can't update course"
      render :edit
    end
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new course_params
    if @course.save
      flash[:success] = "Success! This course has been create successful"
      redirect_to courses_path
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
    params.require(:course).permit(:name, :description, :users_id, :program, :training_standard, :date_start, :status)
  end

  def load_course
    @course = Course.find_by id: params[:id]
    return if @course
    flash[:danger] = "Oop! Can't found course"
    redirect_to :root
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

  def load_subjects course
    @subjects = course.subjects
    @all_subjects = Subject.all
    @all_subjects = @all_subjects.without_course course if @subjects.present?
  end

end
