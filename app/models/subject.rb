class Subject < ApplicationRecord
  has_many :course_subjects, dependent: :destroy
  has_many :courses, through: :course_subjects
  has_many :tasks, inverse_of: :subject, dependent: :destroy
  has_many :detail_links, inverse_of: :subject, dependent: :destroy
  accepts_nested_attributes_for :tasks, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :detail_links, reject_if: :all_blank, allow_destroy: true
  validates :name, presence: true, length: {maximum: 250}, uniqueness: {case_sensitive: false}
  validates :description, length: {maximum: 5000}
  validates :teacher, length: {maximum: 250}
  validates :time, presence: true
  default_scope ->{order(name: :asc)}
  scope :without_course, ->(course){where.not id: course.subjects.pluck(:id)}
  scope :search, ->(search){where("name LIKE ?", "%#{search}%")}

  mount_uploader :avatar, AvatarSubjectUploaded
  paginates_per  7
end
