class CourseSubjectsController < ApplicationController
  before_action :load_course

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
      flash[:success] = "Them mon hoc vao khoa hoc thanh cong"
      redirect_to edit_course_path(@course)
    end
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
