class Course < ApplicationRecord
  has_many :course_subjects, dependent: :destroy
  has_many :user_courses, dependent: :destroy
  validates :name, presence: true, uniqueness: {case_sensitive: false}
  validates :users_id, presence: true
  validates :organization, presence: true
  validates :program, presence: true
  validates :training_standard, presence: true
  validates :status, presence: true
  default_scope ->{order(date_start: :desc)}
  scope :owner, ->(user_id){where users_id: user_id}
  enum status: [:init, :in_progress, :finish, :close]
end
