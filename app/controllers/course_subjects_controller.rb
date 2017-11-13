class CourseSubjectsController < ApplicationController
  before_action :load_course, only: %i(index create)

  def index
    @course_subjects = CourseSubject.of_course @course.id
    @all_subjects = Subject.all
    @all_subjects = @all_subjects.without_course @course if @course_subjects.present?
  end

  def create
    params[:ids].each do |sb|
      date = @course.date_start + sb.to_i
      load_subject sb
      if @course.have sb, date
        flash[:success] = "Them mon #{@subject.name} vao khoa hoc thanh cong"
      else
        flash[:danger] = "Them mon hoc #{@subject.name} vao khoa hoc that bai"
        redirect_to edit_course_path(@course)
      end
    end
    flash[:success] = "Them mon hoc vao khoa hoc thanh cong"
    redirect_to edit_course_path(@course)
  end

  def define_action
    debugger
  end
  private

  def load_subject id
    @subject = Subject.find_by id: id
    return if @course
    flash[:danger] = "Khong tim thay mon hoc"
    redirect_to root_path
  end

  def load_course
    @course = Course.find_by id: params[:course_id]
    return if @course
    flash[:danger] = "Khong tim thay khoa hoc"
    redirect_to root_path
  end
end
