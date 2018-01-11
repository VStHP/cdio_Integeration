class DetailLink < ApplicationRecord
  belongs_to :course, optional: true
  belongs_to :subject, optional: true
  belongs_to :task, optional: true
  validates :name, presence: true, length: {maximum: 250}
  validates :link, presence: true, length: {maximum: 250}
end
