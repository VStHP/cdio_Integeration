class Course < ApplicationRecord
  has_many :course_subjects, dependent: :destroy
  has_many :subjects, through: :course_subjects
  has_many :adding_subject, through: :course_subjects, source: :subject
  has_many :user_courses, dependent: :destroy
  has_many :users, through: :user_courses
  has_many :adding_user, through: :user_courses, source: :user

  validates :name, presence: true, uniqueness: {case_sensitive: false}
  validates :users_id, presence: true
  validates :program, presence: true
  validates :training_standard, presence: true
  validates :status, presence: true

  default_scope ->{order(date_start: :desc)}
  scope :owner, ->(user_id){where users_id: user_id}
  scope :start_today, ->{where date_start: Time.zone.today}
  scope :need_active, ->{where status: "init"}

  enum status: [:init, :in_progress, :finish, :block]

  def add_subject subject
    adding_subject << subject
  end

  def remove_subject subject
    adding_subject.delete subject
  end

  def add_user user
    adding_user << user
  end

  def remove_user user
    adding_user.delete user
  end
end
