class Movie < ActiveRecord::Base
  scope :user_search, ->(user) { where(user_id: user.id) }

  acts_as_voteable

  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :user

  validates :title, presence: true
end
