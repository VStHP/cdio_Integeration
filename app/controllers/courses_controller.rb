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
  end
end
