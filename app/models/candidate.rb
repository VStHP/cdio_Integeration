class Candidate < ApplicationRecord
  validates :name, presence: true, length: {maximum: 250}
  validates :phone, presence: true, length: {maximum: 15}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 250}, format: {with: VALID_EMAIL_REGEX}
  validates :expected_intern, presence: true, length: {maximum: 250}
  validates :note, length: {maximum: 5000}
  validates :cv_url, presence: true
  scope :sort_by_date_new, ->{order(created_at: :desc)}
  scope :in_waiting, ->{where status: "waiting"}
  scope :in_accepted, ->{where status: "accepted"}
  scope :in_excepted, ->{where status: "excepted"}
  mount_uploader :cv_url, CvUploader
  enum status: [:waiting, :accepted, :excepted]
  paginates_per  7
end
