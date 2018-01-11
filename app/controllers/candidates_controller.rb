class CandidatesController < ApplicationController
  before_action :load_candidate, only: :update

  def index
    @candidates = Candidate.sort_by_date_new.page params[:page]
  end

  def update
    if @candidate.update_attributes candidate_params
      @message = "Successfully change status"
    else
      @message = "Failed"
    end
  end

  private

  def load_candidate
    @candidate = Candidate.find_by id: params[:id]
    return if @candidate
    flash[:danger] = "Candidate not found"
    redirect_to root_path
  end

  def candidate_params
    params.require(:candidate).permit :status
  end
end
