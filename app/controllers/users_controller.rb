class UsersController < Devise::RegistrationsController
  skip_before_action :require_no_authentication

  def index
    case params[:option]
    when "trainer"
      @users = User.trainers
    else
      @users = User.trainees
    end
  end

  def new
    super
  end

  def create
    set_password_default
    @user = User.new user_params
    if @user.save
      flash[:info] = t "controllers.users.flash_info_create"
      redirect_to :root
    else
      render :new
    end
  end

  private

  def set_password_default
    case params[:user][:suppervisor]
    when true
      params[:user][:password] = "12345678"
      params[:user][:password_confirmation] = "12345678"
    else
      params[:user][:password] = "123456"
      params[:user][:password_confirmation] = "123456"
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :university, :program, :suppervisor, :password, :password_confirmation)
  end
end
