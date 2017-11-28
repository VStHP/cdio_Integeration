class SubjectsController < ApplicationController
  before_action :load_subject, only: %i(edit update destroy show)

  def new
    @subject = Subject.new
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
    @subjects = Subject.all
  end

  def edit
    @subject = Subject.find_by id: params[:id]
  end

  def update
    respond_to do |f|
      if @subject.update_attributes params_subejct
        f.js{flash[:success] = "Success! This Subject has been update"}
      else
        f.js{flash[:danger] = "Oops! Can't update this subject"}
      end
    end
  end

  def destroy
    if @subject.destroy
      flash[:success] = "Success! This subject has been delete"
    else
      flash[:danger] = "Oops! Can't delete this subject"
    end
    redirect_to subjects_path
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
    params.require(:subject).permit(:name, :desciption, :time, :teacher)
  end
end
