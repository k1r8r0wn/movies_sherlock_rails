class Movie < ActiveRecord::Base
  acts_as_voteable

  extend FriendlyId
  friendly_id :title, use: :slugged

  has_and_belongs_to_many :users

  validates :title, presence: true
end
