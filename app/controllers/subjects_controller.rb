class SubjectsController < ApplicationController
  before_action :logged_in_user
  before_action :load_subject, only: %i(edit update destroy show)

  def new
    @subject = Subject.new
    3.times { @subject.tasks.build}
  end

  def create
    @subject = Subject.new params_subejct
    if @subject.save
      flash[:success] = "Success! This subject has been create"
      redirect_to subjects_path
    else
      flash[:danger] = "Oops! Some error in the create process"
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
      redirect_to subjects_path
    else
      flash[:danger] = "Oops! Can't update this subject"
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
  end

  private

  def load_subject
    @subject = Subject.find_by id: params[:id]
  end

  def params_subejct
    params.require(:subject).permit(:name, :desciption, :time, :teacher,
      tasks_attributes: [:id, :name, :description, :subject_id, :_destroy])
  end
end
