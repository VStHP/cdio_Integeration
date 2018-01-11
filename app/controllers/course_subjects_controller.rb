class CourseSubjectsController < ApplicationController
  before_action :logged_in_user
  skip_before_action :verify_authenticity_token, :only => [:create]
  before_action :load_course, only: %i(index create destroy)
  before_action :verify_can_modify, only: %i(create destroy)
  before_action :load_course_subject, only: %i(update destroy)
  before_action :verify_permited, only: :update
  before_action :verify_can_update, only: :update

  def show
    cs = CourseSubject.find_by subject_id: params[:subject_id], course_id: params[:course_id]
    user_subject = UserSubject.find_by user_id: current_user.id, course_subject_id: cs.id
    @user_tasks = user_subject.user_tasks
  end

  def index
    @course_subjects = CourseSubject.of_course @course.id
    @all_subjects = Subject.search params[:search]
    @all_subjects = @all_subjects.without_course @course if @course_subjects.present?
  end

  def create
    if @permited
      if params[:ids].present?
        @course_subjects = Array.new
        @ids_deny = Array.new
        params[:ids].each do |sb|
          load_subject sb
          course_subject = @course.course_subjects.create subject_id: @subject.id
          if course_subject
            add_user_subject @course, @subject
            @course_subjects << course_subject
          else
            @ids_deny << sb
          end
        end
        @mes_success = "Insert subjects into course successfully"
      else
        @mes_success = "Nothing changes"
      end
    else
      @mes_fail = "This course must be init or in progress"
    end
  end

  def update
    @course = @course_subject.course
    verify_can_modify
    if @permited
      if @course_subject.update_attributes status: params[:status]
        case params[:status]
        when "in_progress"
          @course_subject.update_attributes date_start: Time.zone.today
          flash[:success] = "This subject has been change to in progress successfully"
        else
          @course_subject.update_attributes date_end: Time.zone.today
          flash[:success] = "This subject has been finished, now you can start another subject"
        end
        update_status_user_subject @course_subject
      else
        flash[:danger] = "Oops!! Sorry, your action had been deny"
      end
    else
      flash[:danger] = "This course must be init or in progress"
    end
    redirect_to course_path(id: @course_subject.course.id)
  end

  def destroy
    if @permited
      if @course_subject.destroy
        @mes_success = "Remove subject from course successfully"
      else
        @mes_danger = "Remove subject from course unsuccess"
      end
    else
      @mes_fail = "This course must be init or in progress"
    end
  end

  def del_course_subjects
    if @permited
      if params[:ids].present?
        @ids_deny = Array.new
        @subjects = Array.new
        params[:ids].each do |line|
          subject_cache = CourseSubject.find_by(id: line).subject
          if CourseSubject.find_by(id: line).destroy
            flash[:success] = "Xoa nguoi dung khoi khoa hoc thanh cong"
            @subjects << subject_cache
          else
            flash[:danger] = "Xoa nguoi dung khoi khoa hoc that bai"
            @ids_deny << line
          end
        end
        @mes_success = "Remove subject from course successfully"
      else
        @mes_success = "Nothing changes"
      end
    else
      @mes_fail = "This course must be init or in progress"
    end
  end

  private

  def load_subject id
    @subject = Subject.find_by id: id
    return if @course
    flash[:danger] = "Khong tim thay mon hoc"
    redirect_to root_path
  end

  def load_course_subject
    @course_subject = CourseSubject.find_by id: params[:id]
    return if @course_subject
    flash[:danger] = "Khong tim thay mon hoc"
    redirect_to root_path
  end

  def load_task
    @subject = Subject.find_by id: params[:subject_id]
    @tasks = @subject.tasks
  end

  def load_course
    @course = Course.find_by id: params[:course_id]
    return if @course
    flash[:danger] = "Khong tim thay khoa hoc"
    redirect_to root_path
  end

  def verify_permited
    return if @course_subject.course.in_progress?
    flash[:danger] = "This course must be in progress"
    redirect_to course_path(@course_subject.course.id)
  end

  def verify_can_update
    return if CourseSubject.not_this_course_subject(params[:id]).has_another_in_progress(@course_subject.course.id).blank?
    flash[:danger] = "You can't change status for another subject untill nothing in progress"
    redirect_to course_path(@course_subject.course.id)
  end

  def add_user_subject course, subject
    trainees = course.users.trainees
    course_subject = CourseSubject.find_by course_id: course.id, subject_id: subject.id
    trainees.each do |user|
      user.add_user_subject course_subject
      user_subject = UserSubject.find_by user_id: user.id, course_subject_id: course_subject.id
      course_subject.subject.tasks.each do |task|
        task.add_user_task user_subject
      end
    end
  end

  def update_status_user_subject course_subject
    course_subject.user_subjects.each do |x|
      if x.status != params[:status]
        x.update_attributes status: params[:status]
        case params[:status]
        when "in_progress"
          x.update_attributes date_start: Time.zone.today
        else
          x.update_attributes date_end: Time.zone.today
        end
      end
    end
  end

  def verify_can_modify
    if @course.finish? || @course.block?
      @permited = false
    else
      @permited = true
    end
  end
end
