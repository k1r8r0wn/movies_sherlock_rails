class Movie < ActiveRecord::Base
  acts_as_voteable

  extend FriendlyId
  friendly_id :title, use: :slugged

  has_and_belongs_to_many :users
  mount_uploader :video, VideoUploader
  process_in_background :video

  validates :title, presence: true

  searchable do
    text :title
  end
end
