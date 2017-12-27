class UsersController < Devise::RegistrationsController
  before_action :logged_in_user
  skip_before_action :require_no_authentication
  load_and_authorize_resource
  before_action :load_user, only: :destroy
  before_action :reg_avatar_default, only: %i(create)

  def index
    case params[:option]
    when "trainer"
      @users = User.trainers.page params[:page]
    else
      @users = User.trainees.page params[:page]
    end
  end

  def new
    super
  end

  def create
    set_password_default
    @user = User.new user_params
    if @user.save
      flash[:success] = "Success! User hass been create successfully"
      redirect_to @user
    else
      render :new
    end
  end

  def edit
    super
  end

  def update
    super
  end

  def show
    @user = User.find_by id: params[:id]
  end

  def destroy
    if @user.destroy
      flash[:success] = "Success! #{@user.name} has been delete successfully"
    else
      flash[:danger] = "Error! Can't be delete user #{@user.name}"
    end
    redirect_to root_path
  end

  private

  def reg_avatar_default
    if params[:user][:gender] == "male"
      params[:user][:avatar] = "male-avatar-default.png"
    else
      params[:user][:avatar] = "female-avatar-default.png"
    end
  end

  def params_update
    params.require(:user).permit(:email, :password, :password_confirmation, :current_password)
  end

  def set_password_default
    case params[:user][:suppervisor]
    when true
      params[:user][:password] = "123123"
      params[:user][:password_confirmation] = "123123"
    else
      params[:user][:password] = "123123"
      params[:user][:password_confirmation] = "123123"
    end
  end

  def user_params
    params.require(:user).permit(:name, :gender, :email, :university,
      :program, :suppervisor, :password, :password_confirmation).merge date_start: Time.zone.today
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = "Error! Can't find user"
    redirect_to root_path
  end
end
