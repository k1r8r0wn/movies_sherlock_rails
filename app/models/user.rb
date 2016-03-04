class User < ActiveRecord::Base
  has_many :movies, dependent: :destroy
  has_many :providers, dependent: :destroy

  after_initialize :set_default_role, :if => :new_record?
  before_save :downcase_email

  enum role: [:user, :vip, :admin]

  validates :first_name, presence: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:twitter, :google_oauth2, :github]

  mount_uploader :avatar, AvatarUploader

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email      = auth.info.email
      user.first_name = auth.info.first_name || auth.info.nickname
      user.last_name  = auth.info.last_name
      user.provider   = auth.provider
      user.uid        = auth.uid
      user.save
    end
  end

  # persist user in session on validation error with omniauth
  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
        session["count_errors"] = session["count_errors"] + 1
        session["devise.user_attributes"] = nil if session["count_errors"] == 2
      end
    else
      super
    end
  end

  # validation for password on omniauth
  def password_required?
    super && self.provider.blank?
  end

  # validation for email on omniauth
  def email_required?
    super && self.provider.blank?
  end

  # password for update if blank on omniauth
  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

  def has_no_password?
    self.encrypted_password.blank?
  end

  def set_default_role
    self.role ||= :user
  end

  def downcase_email
    if email.present?
      self.email = email.downcase
    end
  end
end
