module SubjectsHelper
  def display_column_subject_index
    %w(#) + Subject.column_names + %w(Numberdays Tasks) - %w(id created_at updated_at time avatar teacher)
  end

  def style_get_subject arg
    case arg
    when "#"
      @style = "flex: 62 0 auto; width: 62px; max-width: 62px;"
    when "Name"
      @style = "flex: 250 0 auto; width: 250px; max-width: 250px;"
    when "Description"
      @style = "flex: 300 0 auto; width: 300px; max-width: 300px;"
    when "Teacher"
      @style = "flex: 170 0 auto; width: 170px; max-width: 170px;"
    when "Numberdays"
      @style = "flex: 110 0 auto; width: 110px; max-width: 110px;"
    else
      @style = "flex: 62 0 auto; width: 62px; max-width: 62px;"
    end
  end

  def find_cs course, subject
    CourseSubject.find_by(course_id: course.id, subject_id: subject.id)
  end

end
