class Subject < ApplicationRecord
  has_many :course_subjects, dependent: :destroy
  has_many :tasks, dependent: :destroy

  scope :without_course, ->(course){where.not id: course.subjects.pluck(:id)}
end
