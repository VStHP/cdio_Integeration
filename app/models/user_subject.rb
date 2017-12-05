class UserSubject < ApplicationRecord
  belongs_to :user
  belongs_to :course_subject
  has_many  :user_tasks, dependent: :destroy
  has_many :tasks, through: :user_tasks
  has_many :add_tasks, through: :user_tasks, source: :task
  scope :with_course_subject, ->(id){where course_subject_id: id}
  #validates [:user_id, :course_subject_id], uniqueness: {case_sensitive: false}
  enum status: [:init, :in_progress, :finish]

  def add_task_user task
    add_tasks << task
  end

  def del_task_user task
    add_tasks.delete task
  end
end
