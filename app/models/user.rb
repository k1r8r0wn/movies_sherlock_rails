class User < ActiveRecord::Base
  has_many :movies, dependent: :destroy
  has_many :providers, dependent: :destroy

  after_initialize :set_default_role, :if => :new_record?
  # TODO: Uncomment when set up redis & resque in heroku
  # after_create :send_greetings_email
  before_save :downcase_email

  enum role: [:user, :vip, :admin]

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  mount_uploader :avatar, AvatarUploader

  validates :first_name, presence: true

  def apply_omniauth(omniauth)
    self.first_name = omniauth['info']['name'] || omniauth['info']['first_name'] || omniauth['info']['nickname'] if first_name.blank?
    self.last_name =  omniauth['info']['last_name'] if last_name.blank?
    self.email =      omniauth['info']['email'] if email.blank?

    providers.build(:name => omniauth['provider'],
                    :uid => omniauth['uid']
    )
  end

  def password_required?
    (providers.empty? || !password.blank?) && super
  end

  def email_required?
    email && providers.empty?
  end

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

  # TODO: Uncomment when set up redis & resque in heroku
  # def send_greetings_email
  #   UserMailer.follow_up_email(email).deliver_later!(wait: 10.seconds)
  # end
end
