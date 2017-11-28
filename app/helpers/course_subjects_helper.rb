module CourseSubjectsHelper
  def sub_of_course course, subject
    course.course_subjects.find_by subject_id: subject.id
  end

  def course_subject_define id1, id2
    CourseSubject.find_by subject_id: id2, course_id: id1
  end

  def check_status_cs cs
    case true
    when cs.init?
      @status = "init"
      @url = "/images/init.png"
      @body_style = "background: rgba(108, 173, 50, 0.7);"
      @style_btn = "background: #3cadd4;"
    when cs.in_progress?
      @status = "in_progress"
      @url = "/images/inprogress.jpg"
      @body_style = "background: rgba(70, 175, 212, 0.62);"
      @style_btn = "background: #f46d52;"
    else
      @status = "finish"
      @url = "/images/finish.jpg"
      @body_style = "background: rgba(236, 108, 82, 0.72);"
      @style_btn = "background: #000;"
    end
    @class_point = "status status-#{@status}"

  end

  def check_status_btn cs
    case true
    when cs.init?
      @next_status = t ("public.in_progress")
    when cs.in_progress?
      @next_status = t ("public.finish")
    else
      @next_status = t ("public.finish")
    end
  end
  def load_subject_of course_subject
    @subject = Subject.find course_subject.subject_id
  end
end
