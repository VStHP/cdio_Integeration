class Trainee::CoursesController < ApplicationController
  layout "trainee_layout"
  before_action :verify_suppervisor_false
  before_action :logged_in_user, except: %i(index)
  before_action :load_course, except: :index
  load_and_authorize_resource

  def index
    unless user_signed_in?
      redirect_to "/introduction"
    else
      @courses = current_user.courses
    end
  end

  def show
    @course_subjects = @course.course_subjects
    @trainers = @course.users.trainers.alphabet_name
    @trainees = @course.users.trainees.alphabet_name
  end


  private

  def load_course
    @course = Course.find_by id: params[:id]
    return if @course
    flash[:danger] = "Oop! Can't found course"
    redirect_to :root
  end
end
