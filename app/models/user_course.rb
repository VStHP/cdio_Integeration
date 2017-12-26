class UserCourse < ApplicationRecord
  belongs_to :course
  belongs_to :user
  enum status: [:init, :in_progress, :finish, :close]

  scope :of_course, -> (course_id){where course_id: course_id }
  scope :without_course, -> (course_id){where.not course_id: course_id }
  scope :follow_suppervisor, -> (list){where user_id: list.pluck(:id)}
end
