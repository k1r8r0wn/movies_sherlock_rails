class User < ActiveRecord::Base
  has_many :movies, dependent: :destroy

  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end

  validates :first_name, :last_name, presence: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_save :downcase_email

  mount_uploader :avatar, AvatarUploader

  def downcase_email
    self.email = email.downcase
  end
end
