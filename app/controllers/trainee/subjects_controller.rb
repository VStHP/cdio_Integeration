class Trainee::SubjectsController < ApplicationController
  layout "trainee_layout"
  def show
    @subject = Subject.find params[:subject_id]
    cs = CourseSubject.find_by subject_id: params[:subject_id], course_id: params[:course_id]
    @user_subjects = cs.user_subjects
    @user_subject = UserSubject.find_by user_id: current_user.id, course_subject_id: cs.id
    @user_tasks = @user_subject.user_tasks
    @user
  end
end
