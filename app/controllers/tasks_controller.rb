class TasksController < ApplicationController
  def new
    @subject = Subject.find_by id: params[:id]
    @task= Task.new
  end

  def create
      @task = Task.new params_task
      if @task.save
        flash[:success] = "Success! Add new to into subject successfully"
      else
        flash[:danger] = "Oop! Can't add task"
      end
  end

  def edit
  end

  private

  def params_task
    params.require(:task).permit :name, :description, :subject_id
  end

end
