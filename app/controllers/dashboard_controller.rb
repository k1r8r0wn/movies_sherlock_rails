class DashboardController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized

  def index
    authorize :dashboard, :index?
    @count_all_users = User.count
    @count_all_movies = Movie.count
    @count_unique_movies = Movie.uniq.count(:title)
    @popular_movies = Movie.group(:title).count.sort_by { |_key, values| - values}.first(5)
  end
end
