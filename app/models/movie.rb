class Movie < ActiveRecord::Base
  scope :user_search, ->(user) { where(user_id: user.id) }

  belongs_to :user

  validates :title, presence: true
end
