module SubjectsHelper
  def subject_column_for_suppervisor
    Subject.column_names - %w(id created_at updated_at) + %w(action)
  end

  def find_cs course, subject
    CourseSubject.find_by(course_id: course.id, subject_id: subject.id)
  end
end
