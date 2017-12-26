# Preview all emails at http://localhost:3000/rails/mailers/report_progress_mailer
class ReportProgressMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/report_progress_mailer/report_subject
  def report_subject
    ReportProgressMailer.report_subject
  end

end
