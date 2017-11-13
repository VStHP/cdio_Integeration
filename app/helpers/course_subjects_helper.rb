module CourseSubjectsHelper

  def load_subject_of course_subject
    @subject = Subject.find course_subject.subject_id
  end
end
