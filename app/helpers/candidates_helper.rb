module CandidatesHelper
  def display_column_candidate_index
    Candidate.column_names - %w(id created_at updated_at status) + %w(Date Status)
  end
end
