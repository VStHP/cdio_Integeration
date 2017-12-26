class TasksController < ApplicationController
  before_action :logged_in_user
  def new
    @subject = Subject.find_by id: params[:id]
    @task= @subject.tasks.new
  end

  def create
    @task = Task.new params_task
    if @task.save
      save_user_task @task
      @mes_success = 'Task "#{@task.name}" insert into subject "#{@task.subject.name}" successfully'
    else
      @mes_fail = "Can't insert task #{@task.name} into subject #{@task.subject.name}"
    end
  end

  def update
    @task = Task.find params[:id]
    if @task.update_attributes params_task
      @mes_success = 'Update task "#{@task.name}" successfully'
    else
      @mes_fail = "Can't update task #{@task.name} of subject #{@task.subject.name}"
    end
  end

  def edit
    @task = Task.find params[:id]
  end

  private

  def params_task
    params.require(:task).permit :name, :description, :subject_id, :id
  end

  def save_user_task task
    subject = task.subject
    subject.course_subjects.each do |x|
      x.user_subjects.each do |y|
        y.add_task_user task
      end
    end
  end

end
