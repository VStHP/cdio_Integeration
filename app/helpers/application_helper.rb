module ApplicationHelper
  def full_title page_title = ""
    base_title = "Online Education"
    if page_title.blank?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def check_status_user_task user_task
   unless user_task.blank?
      case user_task.status
      when "in_progress"
        @name_plugin = " /in progress/ /let's finish this task to receive new task/"
        @btn_text = "Finish Task"
        @body_class = "in_progress"
        @style_btn =  "background: #f46d52;"
      when "finish"
        @name_plugin = " /finish/"
        @btn_text = "Done!"
        @body_class = "finish"
        @style_btn = "background: #f46d52;"
      else
        @name_plugin = " /init/ /let's receive task!/"
        @btn_text = "Receive Task"
        @body_class = ""
        @style_btn = "background: #3cadd4;"
      end
    else
      @btn_text = "Receive Task"
      @body_class = "background: rgba(108, 173, 50, 0.7) ;"
      @style_btn = "background: #3cadd4;"
    end
  end

  def show_errors object, name_attribute, name_error
    messages = object.errors.messages[name_attribute]
    return "#{messages[0]}" if messages.present?
  end
end
