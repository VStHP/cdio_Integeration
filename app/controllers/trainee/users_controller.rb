class Trainee::UsersController < ApplicationController
  layout "trainee_layout"
  before_action :logged_in_user
  before_action :load_user
  load_and_authorize_resource

  private

  def load_user
    user = User.find_by id: params[:id]
    return if user
    flash[:danger] = "Couldn't find user"
    redirect_to root_path
  end
end
