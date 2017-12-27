class UserTask < ApplicationRecord
  belongs_to :task
  belongs_to :user_subject
  scope :with_user_subject, ->(id){where user_subject_id: id}
  scope :not_this, ->(id){where.not id: id}
  scope :status_in_progress, ->{where status: "in_progress"}
  scope :finish, ->{where status: "finish"}
  enum status: [:init, :in_progress, :finish, :block]
end
