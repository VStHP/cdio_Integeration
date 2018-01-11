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
        @btn_text = "Finish Task"
        @body_class = "in_progress"
        @style_btn =  "background: #f46d52;"
        @text = "IN PROGRESSING"
      when "finish"
        @btn_text = "Done!"
        @body_class = "finish"
        @style_btn = "background: #f46d52;"
        @text = "FINISH"
      else
        @btn_text = "Receive Task"
        @body_class = "init"
        @style_btn = "background: #3cadd4;"
        @text = "READY"
      end
    else
      @btn_text = "Receive Task"
      @style_btn = "background: #3cadd4;"
    end
  end

  def show_errors object, name_attribute, name_error
    messages = object.errors.messages[name_attribute]
    return "#{messages[0]}" if messages.present?
  end
end
