class User < ActiveRecord::Base
  has_secure_password

  has_many :movies,  dependent: :destroy

  validates :email, :first_name, :last_name, presence: true
  validates :email, uniqueness: true,
            format: {
                with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9\.-]+\.[A-Za-z]+\Z/
            }

  before_save :downcase_email

  def downcase_email
    self.email = email.downcase
  end

  def generate_password_reset_token!
    update_attribute(:password_reset_token, SecureRandom.urlsafe_base64(48))
  end
end
