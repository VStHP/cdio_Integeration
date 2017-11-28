class UserTask < ApplicationRecord
  belongs_to :task
  belongs_to :user_subject
  scope :with_user_subject, ->(id){where user_subject_id: id}
  enum status: [:init, :in_progress, :finish]
end
