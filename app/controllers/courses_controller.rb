  class CoursesController < ApplicationController
  before_action :logged_in_user
  before_action :verify_suppervisor_true
  load_and_authorize_resource param_method: :course_params

  def index
    unless user_signed_in?
      redirect_to "/introduction"
    else
      unless current_user.suppervisor?
        @courses = current_user.courses
      else
        case params[:option]
        when "1"
          @courses = Course.owner(current_user.id).page params[:page]
        when "2"
          @courses = current_user.courses.page params[:page]
        else
          @courses = Course.all.page params[:page]
        end
      end
    end
  end

  def show
    @course_subjects = @course.course_subjects
    @trainers = @course.users.trainers.alphabet_name
    @trainees = @course.users.trainees.alphabet_name
  end

  def edit; end

  def update
    if @course.update_attributes course_params
      if params[:course][:status] == "finish"
        @course.update_attributes date_end: Time.zone.today
        @course.course_subjects.each do |cs|
          cs.update_attributes status: "finish"
          cs.user_subjects.each do |us|
            unless us.finish?
              us.update_attributes status: "block"
            end
          end
        end
      end
      flash[:success] = "Success! This course has been update successful"
      redirect_to @course
    else
      render :edit
    end
  end

  def new
    @course = Course.new
  end

  def create
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
        @mes_success = "Delete #{@course.name} successful"
      else
        @mes_fail = "Delete #{@course.name} unsuccessful"
      end
    else
      @mes_fail = "#{@course.name} had been active, delete is unpermitted"
    end
  end

  def block_course
    if @course.update_attributes status: params[:status]
      if params[:status] == "block"
        @mes_success = "#{@course.name} has been locked"
      else
        @mes_success = "#{@course.name} has been unlocked"
      end
    else
      @mes_danger = "WARNING! HAS AN ERROR"
    end
  end

  private

  def course_params
    params[:course][:date_start] = Date.strptime(params[:course][:date_start], "%m/%d/%Y")
    params.require(:course).permit(:name, :description, :users_id, :program, :training_standard,
      :date_start, :avatar, :banner)
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
