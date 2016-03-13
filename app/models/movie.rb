class Movie < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true

  scope :user_search, ->(user) { where(user_id: user.id) }

end
