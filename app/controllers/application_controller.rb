class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionHelper
  before_action :active_course_automation, if: :user_signed_in?
  before_action :configure_permitted_parameters, if: :devise_controller?

  def logged_in_user
    return if user_signed_in?
    store_location
    flash[:danger] = "Please log in system to work!"
    redirect_to login_url
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:danger] = "WARNING! YOU ARE UNPERMITED"
    redirect_to root_path
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    flash[:danger] = " ~404~ ! NOT FOUND"
    redirect_to root_path
  end

  def verify_user? user
    current_user == user
  end

  def active_course_automation
    @courses = Course.start_today.need_active
    count = 0
    @courses.each do |c|
      c.update_attributes status: "in_progress"
      c.users.need_active_date_start.each do |u|
        u.update_attributes date_start: Time.zone.today
      end
      count += 1
    end
    if count > 1
      show = "#{count} courses"
    else
      show = "#{count} course"
    end
    # unless current_user.trainee?
    #   flash[:info] = "#{show} has been active in progress today"
    # end
  end

  def verify_suppervisor_true
    if current_user.trainee?
      redirect_to root_path
    end
  end

  def verify_suppervisor_false
    unless current_user.trainee?
      redirect_to root_path
    end
  end

  def configure_permitted_parameters
    # devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me, :avatar, :avatar_cache) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:username, :password, :password_confirmation, :current_password, :avatar, :avatar_cache, :remove_avatar) }
  end
  # def has_logged?
  #   logged_in?
  # end
end
