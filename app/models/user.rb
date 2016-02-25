class User < ActiveRecord::Base
  validates :email, presence: true
  validates :email, uniqueness: true,
            format: {
                with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9\.-]+\.[A-Za-z]+\Z/
            }

  before_save :downcase_email

  def downcase_email
    self.email = email.downcase
  end
end
