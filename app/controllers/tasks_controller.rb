class TasksController < ApplicationController
  before_action :logged_in_user
  def new
    @subject = Subject.find_by id: params[:id]
    @task= Task.new
  end

  def create
      @task = Task.new params_task
      if @task.save
        save_user_task @task
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

  def save_user_task task
    binding.pry
    subject = Subject.find_by id: params[:task][:subject_id]
    subject.course_subjects.each do |x|
      x.user_subjects.each do |y|
        y.add_task_user task
      end
    end
  end

end
