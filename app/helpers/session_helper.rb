module SessionHelper

  def log_in user
    session[:user_id] = user.id
  end

  def log_out
    session.delete :user_id
    @current_user = nil
  end

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by id: user_id
    end
  end

  def logged_in?
    current_user.present?
  end


  def redirect_back_or default
    redirect_url = root_path
    unless default.nil?
      redirect_url = root_path
      # redirect_url = suppervisor_users_path if default.suppervisor?
    end
    redirect_to session[:forwarding_url] || redirect_url
    session.delete :forwarding_url
  end

  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end
