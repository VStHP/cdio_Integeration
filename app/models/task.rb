class Task < ApplicationRecord
  belongs_to :subject
  has_many :user_tasks, dependent: :destroy
  has_many :having_users, through: :user_tasks, source: :user_subject
  validates :name, presence: true
  validate :name_is_only_1_with_a_subject

  scope :has_same_name, ->(name){where name: name.downcase}
  scope :of_subject, ->(subject_id){where subject_id: subject_id}

  def add_user_task user_subject
    having_users << user_subject
  end
  private

  def name_is_only_1_with_a_subject
    return if Task.of_subject(subject_id).has_same_name(name).nil?
    errors.add :name, 'Task name is already in system with this subject'
  end
end
