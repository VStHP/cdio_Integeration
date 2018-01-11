class Trainee::CandidatesController < ApplicationController
  skip_before_action :verify_authenticity_token
  layout "layout2"

  def new
    @candidate = Candidate.new
  end

  def create
    @candidate = Candidate.new params_candidate
    if @candidate.save
      @mes_success = "Successfully register!"
      RegisterInternshipMailer.notification_register_success(params).deliver_now
    end
  end

  private

  def params_candidate
    params.require(:candidate).permit :name, :email, :phone, :expected_intern, :note, :cv_url, :status
  end
end
