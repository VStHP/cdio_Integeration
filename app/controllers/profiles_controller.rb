class ProfilesController < ApplicationController
  before_action :logged_in_user
  before_action :load_user

  def edit
    if current_user.trainee?
      check_user_permit
    end
  end

  def update
    if current_user.trainee?
      check_user_permit
    else
        if @user.update_attributes profile_params
          flash[:success] = "Success! Your profile has been update successfully"
        else
          flash[:danger] = "Oops! Some error in the update process"
        end
    end
  end

  private

  def profile_params
    params.require(:user).permit(:name, :email, :university, :program, :date_start)
  end

  def check_user_permit
    unless verify_user? @user
      respond_to do |f|
        f.js{flash[:danger] = "Warning! Your account unpermitted to do this"}
      end
    end
  end

  def load_user
    @user = User.find_by id: params[:id]
  end
end
