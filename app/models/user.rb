class User < ApplicationRecord
  has_many :user_courses, dependent: :destroy
  has_many :user_subjects, dependent: :destroy

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 50},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :name, presence: true, length: {maximum: 50}
  has_secure_password
  validates :password, presence: true, length: {minimum: 6}, allow_nil: true
end
