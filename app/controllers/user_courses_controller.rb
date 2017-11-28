class UserCoursesController < ApplicationController
  before_action :load_course, only: %i(index create del_user_courses)

  def index
    @all_trainers = User.trainers.search params[:search]
    @trainer_courses = UserCourse.of_course(@course.id).is_trainer(User.trainers)
    @all_trainers = @all_trainers.without_course @course if @trainer_courses.present?
    @all_trainees = User.trainees.search params[:search_trainee]
    @trainee_courses = UserCourse.of_course(@course.id).is_trainee(User.trainees)
    @all_trainees = @all_trainees.without_course @course if @trainee_courses.present?
    @option = params[:option]
  end

  def create
    params[:ids].each do |user|
      load_user user
      if @course.add_user @user
        if @user.trainee?
          add_user_subject @course, @user
        end
        flash[:success] = "Them mon #{@user.name} vao khoa hoc thanh cong"
      else
        flash[:danger] = "Them mon hoc #{@user.name} vao khoa hoc that bai"
        redirect_to user_courses_path(course_id: @course.id)
      end
    end
    user = User.find params[:ids].first
    if user.trainee?
      option = "trainee"
    end
    flash[:success] = "Them mon hoc vao khoa hoc thanh cong"
    redirect_to user_courses_path(course_id: @course.id, option: option)
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
      course = UserCourse.find_by(id: line).course
      user = UserCourse.find_by(id: line).user
      if user.trainee?
        course_subjects = course.course_subjects
        course_subjects.each do |cs|
          user.remove_user_subject cs
        end
      end
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

  def add_user_subject course, user
    course_subjects = course.course_subjects
    course_subjects.each do |course_subject|
      user.add_user_subject course_subject
      user_subject = UserSubject.find_by user_id: user.id, course_subject_id: course_subject.id
      course_subject.subject.tasks.each do |task|
        task.add_user_task user_subject
      end
    end
  end
end
