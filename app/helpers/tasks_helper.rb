module TasksHelper
  def define_cancel_task_id task
    if task.id?
      "cancel_task_edit"
    else
      "cancel_task_new"
    end
  end

  def calc_percent user_subject
    total = user_subject.user_tasks.size
    if total != 0
      finish = user_subject.user_tasks.finish.size
      @percent = ((finish.to_f/total) * 100).to_i
    else
      @percent = 100
    end
    if @percent <= 20
      @class = "progress-bar progress-bar-danger"
    elsif @percent<=40
      @class = "progress-bar progress-bar-warning"
    elsif @percent<=60
      @class = "progress-bar progress-bar-info"
    else
      @class = "progress-bar progress-bar-success"
    end
  end
end
