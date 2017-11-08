class UserCourse < ApplicationRecord
  belongs_to :course
  belongs_to :user
  enum status: [:init, :in_progress, :finish, :close]
end
