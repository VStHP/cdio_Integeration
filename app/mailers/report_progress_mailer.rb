class ReportProgressMailer < ApplicationMailer
  add_template_helper(EmailHelper)
  default from: "educationonline@gmail.com"

  def report_subject user_subject
    @user = user_subject.user
    @subject = user_subject.subject
    @course = user_subject.course
    @course.users.trainers.each do |user|
      mail(to: user.email, subject: "Trainee had been finished all tasks of subject")
    end
    mail(to: "ngoctam3096@gmail.com", subject: "Trainee had been finished all tasks of subject")
  end
end