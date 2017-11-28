class UserSubject < ApplicationRecord
  belongs_to :user
  belongs_to :course_subject
  has_many  :user_tasks, dependent: :destroy
  has_many :tasks, through: :user_tasks
  scope :with_course_subject, ->(id){where course_subject_id: id}
  #validates [:user_id, :course_subject_id], uniqueness: {case_sensitive: false}
  enum status: [:init, :in_progress, :finish]
end
