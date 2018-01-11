class SubjectsController < ApplicationController
  before_action :logged_in_user
  # before_action :load_subject, only: %i(edit update destroy show)
  load_and_authorize_resource param_method: :params_subejct

  def new
    @subject = Subject.new
    1.times { @subject.tasks.build}
    1.times { @subject.detail_links.build}
  end

  def create
    # @subject = Subject.new params_subejct
    if @subject.save
      flash[:success] = "Success! This subject has been create"
      redirect_to @subject
    else
      flash[:danger] = "Oops! Some error in the create process"
      1.times { @subject.tasks.build}
      1.times { @subject.detail_links.build}
      render :new
    end
  end

  def index
    @subjects = Subject.all.page params[:page]
  end

  def edit
    @subject = Subject.find_by id: params[:id]
  end

  def update
    if @subject.update_attributes params_subejct
      flash[:success] = "Success! This Subject has been update"
      redirect_to @subject
    else
      flash[:danger] = "Oops! Can't update this subject"
      1.times { @subject.tasks.build}
      1.times { @subject.detail_links.build}
      render :edit
    end
  end

  def destroy
    if @subject.destroy
      @mes_success = "Delete #{@subject.name} successfully"
    else
      @mes_fail = "Delete #{@subject.name} unsuccessfully"
    end
  end

  def show
    @courses = @subject.courses
    @tasks = @subject.tasks
    @detail_links = @subject.detail_links
  end

  def show_subject_in_course
    @subject = Subject.find params[:subject_id]
    @course_subject = CourseSubject.find_by subject_id: params[:subject_id], course_id: params[:course_id]
    @user_subjects = @course_subject.user_subjects
    @tasks = @subject.tasks
  end

  private

  def load_subject
    @subject = Subject.find_by id: params[:id]
  end

  def params_subejct
    params.require(:subject).permit(:name, :description, :time,
      detail_links_attributes: [:id, :name, :link, :subject_id, :_destroy],
      tasks_attributes: [:id, :name, :description, :subject_id, :_destroy, :link_video])
  end
end
