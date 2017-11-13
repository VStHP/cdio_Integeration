class UserCourse < ApplicationRecord
  belongs_to :course
  belongs_to :user
  enum status: [:init, :in_progress, :finish, :close]

  scope :of_course, -> (course_id){where course_id: course_id }
  scope :is_trainer, -> (list_trainers){where user_id: list_trainers.pluck(:id)}
  scope :is_trainee, -> (list_trainees){where user_id: list_trainees.pluck(:id)}
end
