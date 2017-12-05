class Subject < ApplicationRecord
  has_many :course_subjects, dependent: :destroy
  has_many :courses, through: :course_subjects
  has_many :tasks, dependent: :destroy
  validates :name, presence: true, length: {maximum: 100}, uniqueness: {case_sensitive: false}
  validates :description, length: {maximum: 250, minimun: 20}
  validates :time, presence: true

  scope :without_course, ->(course){where.not id: course.subjects.pluck(:id)}
  scope :search, ->(search){where("name LIKE ?", "%#{search}%")}

  paginates_per  7
end
