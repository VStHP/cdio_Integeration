class CourseSubject < ApplicationRecord
  belongs_to :course
  belongs_to :subject
  has_many :user_subjects, dependent: :destroy
  enum status: [:init, :in_progress, :finish]

  scope :of_course, -> (course_id){where course_id: course_id}
end
