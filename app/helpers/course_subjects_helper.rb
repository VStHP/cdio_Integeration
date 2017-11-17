module CourseSubjectsHelper
  def sub_of_course course, subject
    course.course_subjects.find_by subject_id: subject.id
  end

  def check_status_cs cs
    case true
    when cs.init?
      @status = t ("public.init")
    when cs.in_progress?
      @status = t ("public.in_progress")
    else
      @status = t ("public.finish")
    end
    @class = "status status-#{@status}"
  end

  def check_status_btn cs
    case true
    when cs.init?
      @next_status = t ("public.in_progress")
      @btn_class = "btn btn-success"
    when cs.in_progress?
      @next_status = t ("public.finish")
      @btn_class = "btn btn-danger"
    else
      @next_status = t ("public.finish")
      @btn_class = "btn status-btn-dis"
    end
  end
  def load_subject_of course_subject
    @subject = Subject.find course_subject.subject_id
  end
end
