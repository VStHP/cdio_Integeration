class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionHelper

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = "Please log in system to work!"
    redirect_to login_url
  end

  def has_logged?
    logged_in?
  end
end
