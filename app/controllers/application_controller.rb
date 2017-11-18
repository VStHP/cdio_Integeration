class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionHelper

  def logged_in_user
    return if user_signed_in?
    store_location
    flash[:danger] = "Please log in system to work!"
    redirect_to login_url
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:warning] = exception.message
    redirect_to root_path
  end
  # def has_logged?
  #   logged_in?
  # end
end
