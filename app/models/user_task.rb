class UserTask < ApplicationRecord
  belongs_to :task
  belongs_to :user_subject
  enum status: [:init, :in_progress, :finish]
end
