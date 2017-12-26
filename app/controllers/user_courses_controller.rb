class UserCoursesController < ApplicationController
  before_action :logged_in_user
  before_action :load_course, only: %i(index create del_user_courses)
  before_action :load_user_course, only: :destroy

  def index
    @users_system = User.belongs_to_suppervisor params[:option]
    @users_course = @course.user_courses.follow_suppervisor @users_system
    @users_system = @users_system - @course.users
  end

  def create
    if params[:ids].present?
      @user_courses = Array.new
      @ids_deny = Array.new
      params[:ids].each do |user|
        load_user user
        user_course = @course.user_courses.create user_id: @user.id
        if user_course
          if @user.trainee?
            add_user_subject @course, @user
          end
          @user_courses << user_course
        else
          @ids_deny << user
        end
      end
      @mes_success = "Insert user into course successfully"
    else
      @mes_success = "Nothing changes"
    end
  end

  def destroy
    if @user_course.destroy
      if @user_course.user.trainee?
        course_subjects = @user_course.course.course_subjects
        course_subjects.each do |cs|
          @user_course.user.user_subjects.find_by(course_subject_id: cs.id).destroy
        end
      end
      @mes_success = "Remove user from course successfully"
    else
      @mes_danger = "Remove user from course unsuccess"
    end
  end

  def destroy_user line
    if line.destroy
      flash[:success] = "Xoa nguoi dung khoi khoa hoc thanh cong"
    else
      flash[:danger] = "Xoa nguoi dung khoi khoa hoc that bai"
      redirect_to user_courses_path(course_id: @course.id)
    end
  end

  def del_user_courses
    if params[:ids].present?
      @ids_deny = Array.new
      @users = Array.new
      params[:ids].each do |line|
        user_cache = UserCourse.find_by(id: line).user
        @uc = UserCourse.find_by(id: line)
        if UserCourse.find_by(id: line).destroy
          @users << user_cache
          course = @uc.course
          if user_cache.trainee?
            course_subjects = course.course_subjects
            course_subjects.each do |cs|
              user_cache.user_subjects.find_by(course_subject_id: cs.id).destroy
            end
          end
        else
          @ids_deny << line
        end
      end
      @mes_success = "Remove users from course successfully"
    else
      @mes_success = "Nothing changes"
    end
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
      user_subject = user.user_subjects.create course_subject_id: course_subject.id
      course_subject.subject.tasks.each do |task|
        task.user_tasks.create user_subject_id: user_subject.id
      end
    end
  end

  def load_user_course
    @user_course = UserCourse.find_by id: params[:id]
    return if @user_course
    flash[:danger] = "There was an error"
    redirect_to root_path
  end
end
