class SiteStatisticsController < ApplicationController
  before_filter :authenticate_user!
  after_action :verify_authorized

  def index
    authorize self
    @all_users = User.count
    @all_movies = Movie.count
    @unique_movies = Movie.uniq.count(:title)
    @popular_movies = Movie.group(:title).count.sort_by { |_key, values| - values}.first(5)
  end
end
