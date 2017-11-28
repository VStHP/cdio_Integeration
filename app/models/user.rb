class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_courses, dependent: :destroy
  has_many :courses, through: :user_courses
  has_many :user_subjects, dependent: :destroy
  has_many :having_subject, through: :user_subjects, source: :course_subject

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 50},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :name, presence: true, length: {maximum: 50}
  validates :password, presence: true, length: {minimum: 6}, allow_nil: true

  scope :trainers, ->{where suppervisor: "trainer"}
  scope :trainees, ->{where suppervisor: "trainee"}
  scope :without_course, ->(course){where.not id:course.users.pluck(:id)}
  scope :search, ->(search){where("name LIKE ?", "%#{search}%")}
  scope :need_active_date_start, ->{where date_start: nil}
  scope :with_ids, ->(ids){where id: ids}
  scope :alphabet_name, ->{order(name: :desc)}
  enum suppervisor: [:trainee, :trainer, :admin]
  enum gender: [:male, :female]
  mount_uploader :avatar, AvatarUploader
  validates_integrity_of  :avatar
  validates_processing_of :avatar
  class << self
    def digest string
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def add_user_subject course_subject
    having_subject << course_subject
  end

  def remove_user_subject course_subject
    having_subject.delete course_subject
  end

  def remember
    self.remember_token = User.new_token
    update_attributes(remember_digest: User.digest(remember_token))
  end

  def authenticated? attribute, token
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update_attributes(remember_digest: nil)
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_attributes(reset_digest: User.digest(reset_token), reset_sent_at: Time.zone.now)
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  private

  def downcase_email
    self.email = email.downcase
  end

  def avatar_size_validation
    errors[:avatar] << "should be less than 500KB" if avatar.size > 0.5.megabytes
  end
end
