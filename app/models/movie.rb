class Movie < ActiveRecord::Base
  scope :user_search, ->(user) { where(user_id: user.id) }

  acts_as_voteable

  belongs_to :user

  validates :title, presence: true
end
