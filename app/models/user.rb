class User < ActiveRecord::Base
  has_many :movies, dependent: :destroy

  after_initialize :set_default_role, :if => :new_record?
  before_save :downcase_email

  enum role: [:user, :vip, :admin]

  validates :first_name, :last_name, presence: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:twitter]

  mount_uploader :avatar, AvatarUploader

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end

  def set_default_role
    self.role ||= :user
  end

  def downcase_email
    self.email = email.downcase
  end
end
