class StaticPagesController < ApplicationController
  def home
    unless user_signed_in?
      redirect_to "/introduction"
    else
      if current_user.trainee?
        redirect_to mycourses_path
      else
        redirect_to courses_path(option: 3)
      end
    end
  end
end
