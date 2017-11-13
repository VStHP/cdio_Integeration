class UserCoursesController < ApplicationController
  before_action :load_course, only: %i(index create del_user_courses)

  def index
    @all_trainers = User.trainers.search params[:search]
    @trainer_courses = UserCourse.of_course(@course.id).is_trainer(User.trainers)
    @all_trainers = @all_trainers.without_course @course if @trainer_courses.present?
    @all_trainees = User.trainees.search params[:search_trainee]
    @trainee_courses = UserCourse.of_course(@course.id).is_trainee(User.trainees)
    @all_trainees = @all_trainees.without_course @course if @trainee_courses.present?
  end

  def create
    params[:ids].each do |user|
      load_user user
      if @course.add_user @user
        flash[:success] = "Them #{@user.name} vao khoa hoc thanh cong"
      else
        flash[:danger] = "Them #{@user.name} vao khoa hoc that bai"
        redirect_to user_courses_path(course_id: @course.id)
      end
    end
    flash[:success] = "Them nguoi dung vao khoa hoc thanh cong"
    redirect_to user_courses_path(course_id: @course.id)
  end

  def destroy line
    if line.destroy
      flash[:success] = "Xoa nguoi dung khoi khoa hoc thanh cong"
    else
      flash[:danger] = "Xoa nguoi dung khoi khoa hoc that bai"
      redirect_to user_courses_path(course_id: @course.id)
    end
  end

  def del_user_courses
    params[:ids].each do |line|
      destroy UserCourse.find_by id: line
    end
    flash[:success] = "Xoa nguoi dung khoi khoa hoc thanh cong"
    redirect_to user_courses_path(course_id: @course.id)
  end
  private

  def load_user id
    @user = User.find_by id: id
    return if @user
    flash[:danger] = "Khong tim thay nguoi dung"
    redirect_to root_path
  end

  def load_course
    @course = Course.find_by id: params[:course_id]
    return if @course
    flash[:danger] = "Khong tim thay khoa hoc"
    redirect_to root_path
  end
end
