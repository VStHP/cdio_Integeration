class UserTasksController < ApplicationController
  before_action :load_user_task
  before_action :verify_subject_must_be_active
  def update
    binding.pry
    if @ut.update_attributes params_user_task
      case params[:status]
      when "in_progress"
        flash[:success] = "You had been receiver task, let do it! Good Luck"
      else
        flash[:success] = "You had been finish task, Excelent!"
      end
    else
      flash[:danger] = "Sorry, this is error"
    end
    redirect_back fallback_location: root_path
  end

  private

  def load_user_task
    @ut = UserTask.find_by id: params[:id]
    return if @ut
    flash[:danger] = "update unsuccess"
    redirect_back fallback_location: root_path
  end

  def params_user_task
    params.permit :status
  end

  def verify_subject_must_be_active
    return unless @ut.user_subject.course_subject.init?
    flash[:danger] = "Sorry, this subject need active to report"
    redirect_back fallback_location: root_path
  end
end
