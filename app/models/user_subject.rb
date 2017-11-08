class UserSubject < ApplicationRecord
  belongs_to :user
  belongs_to :course_subject
  has_many  :user_tasks, dependent: :destroy
  enum status: [:init, :in_progress, :finish]
end
