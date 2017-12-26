class ProfilesController < ApplicationController
  before_action :logged_in_user
  before_action :load_user
  before_action { unauthorized! if cannot? :update, @user }

  def edit; end

  def update
    if @user.update_attributes profile_params
      @mes_success = "Success! Your profile has been update successfully"
    end
  end

  def updateAvatar
    if @user.update_attributes avatar_params
      @mes_success_avatar = "Update avatar successfully!"
    else
      @mes_danger = "Update avatar failed!"
    end
  end

  private

  def profile_params
    params.require(:user).permit :name, :email, :university, :program, :date_start
  end

  def avatar_params
    params.require(:user).permit :avatar
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
