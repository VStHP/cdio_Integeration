class RegisterInternshipMailer < ApplicationMailer
  default from: "it_stCompany@gmail.com"

  def notification_register_success params
    @params = params
    mail(to: params[:candidate][:email], subject: "Registry Internship - IT stCompany")
  end
end
